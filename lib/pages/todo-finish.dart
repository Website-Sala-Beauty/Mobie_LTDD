import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/services/local/shared_perferences.dart';

import '../components/app_color.dart';
import '../components/search_box.dart';
import '../components/todo_item.dart';

import '../models/todo_model.dart';

class ToDoFinshPage extends StatefulWidget {
  const ToDoFinshPage({super.key});

  @override
  State<ToDoFinshPage> createState() => _ToDoFinshPageState();
}

class _ToDoFinshPageState extends State<ToDoFinshPage> {
  final _searchController = TextEditingController();

  List<TodoModel> _searches = [];
  List<TodoModel> _listData = [];

  final SharePrefs _prefs = SharePrefs();

  @override
  void initState() {
    super.initState();
    //_searches = [...todos];
    _getToDo();
  }

  _searchTodos(String searchText) {
    searchText = searchText.toLowerCase();

    _searches = _listData
        .where((element) =>
            (element.text ?? '').toLowerCase().contains(searchText))
        .toList();
  }

  _getToDo() async {
    _prefs.getTodo().then((value) {
      setState(() {
        // chỉ cần gán _listData = value với nhứn todo isDone = true
        if (value != null) {
          _listData = value.toList(); // danh sách gốc để thực hiện cập nhật lại
          _searches =
              [..._listData].where((element) => element.status == 2).toList();
        }
        // _listData = value ?? todos;
        // _searches = [..._listData];
        //todos = [..._listData];
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 12.0, bottom: 92.0),
                child: Column(
                  children: [
                    SearchBox(
                        onChanged: (value) =>
                            setState(() => _searchTodos(value)),
                        controller: _searchController),
                    const Divider(
                        height: 32.6, thickness: 1.36, color: AppColor.grey),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searches.length,
                      itemBuilder: (context, index) {
                        TodoModel todo = _searches.reversed.toList()[index];
                        return TodoItem(
                          onTap: () {
                            setState(() {
                              todo.isDone = false;
                              todo.status = 1;
                              _prefs.addBills(_listData);
                              // cập nhật lại dữ liệu shared preferences sau khi thay đổi để dữ liệu được cập nhật ở cả 2 màn hình
                              // sau 5s thì gọi lại hàm getToDo để cập nhật lại dữ liệu
                              Future.delayed(const Duration(seconds: 1), () {
                                _getToDo();
                              });
                              //_getToDo();
                            });
                          },
                          onDeleted: () async {
                            // bool? status = await showDialog<bool>(
                            //   context: context,
                            //   builder: (BuildContext context) => AlertDialog(
                            //     title: const Text('😍'),
                            //     content: Row(
                            //       children: const [
                            //         Expanded(
                            //           child: Text(
                            //             'Do you want to remove the todo?',
                            //             style: TextStyle(fontSize: 22.0),
                            //             textAlign: TextAlign.center,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     actions: [
                            //       TextButton(
                            //         onPressed: () =>
                            //             Navigator.pop(context, false),
                            //         child: const Text('Cancel'),
                            //       ),
                            //       TextButton(
                            //         onPressed: () =>
                            //             Navigator.pop(context, true),
                            //         child: const Text('OK'),
                            //       ),
                            //     ],
                            //   ),
                            // );
                            // if (status ?? false) {
                            setState(() {
                              //_listData.remove(todo);
                              todo.status = 3;
                              _searches.remove(todo);
                              _prefs.addBills(_listData);
                              // cập nhật lại dữ liệu shared preferences sau khi thay đổi để dữ liệu được cập nhật ở cả 2 màn hình
                              // sau 5s thì gọi lại hàm getToDo để cập nhật lại dữ liệu
                              Future.delayed(const Duration(seconds: 1), () {
                                _getToDo();
                              });
                            });
                            //  }
                          },
                          text: todo.text ?? '-:-',
                          isDone: todo.isDone ?? false,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16.8),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
