import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/services/local/shared_perferences.dart';

import '../components/app_color.dart';
import '../components/search_box.dart';
import '../components/todo_item.dart';

import '../models/todo_model.dart';

class ToDoDeletePage extends StatefulWidget {
  const ToDoDeletePage({super.key});

  @override
  State<ToDoDeletePage> createState() => _ToDoDeletePageState();
}

class _ToDoDeletePageState extends State<ToDoDeletePage> {
  final _searchController = TextEditingController();
  final _addController = TextEditingController();
  final _addFocus = FocusNode();
  bool _showAddBox = false;
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
            (element.text ?? '').toLowerCase().contains(searchText) &&
            element.status == 1)
        .toList();
  }

  _getToDo() async {
    _prefs.getTodo().then((value) {
      setState(() {
        // chỉ cần gán _listData = value với nhứn todo isDone = true
        if (value != null) {
          _listData = value.toList(); // danh sách gốc để thực hiện cập nhật lại
          _searches =
              [..._listData].where((element) => element.status == 3).toList();
        }
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
                        return Visibility(
                          visible: _listData
                              .where((element) => element.status == 3)
                              .toList()
                              .isNotEmpty,
                          child: TodoItem(
                            status: todo.status,
                            onDeleted: () async {
                              bool? status = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('😍'),
                                  content: Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Do you want to remove the todo?',
                                          style: TextStyle(fontSize: 22.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              if (status ?? false) {
                                setState(() {
                                  //_listData.remove(todo);
                                  // todo.status = 3;
                                  _listData.remove(todo);
                                  //_searches.remove(todo);
                                  _prefs.addBills(_listData);
                                  // cập nhật lại dữ liệu shared preferences sau khi thay đổi để dữ liệu được cập nhật ở cả 2 màn hình
                                  // sau 5s thì gọi lại hàm getToDo để cập nhật lại dữ liệu
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    _getToDo();
                                  });
                                });
                              }
                            },
                            restore: () {
                              setState(() {
                                if (todo.isDone == true) {
                                  todo.status = 2;
                                } else {
                                  todo.status = 1;
                                }
                                _prefs.addBills(_listData);
                                _getToDo();
                                // cập nhật lại dữ liệu shared preferences sau khi thay đổi để dữ liệu được cập nhật ở cả 2 màn hình
                                // sau 5s thì gọi lại hàm getToDo để cập nhật lại dữ liệu
                                // Future.delayed(const Duration(seconds: 1), () {
                                //   _getToDo();
                                // });
                              });
                            },
                            text: todo.text ?? '-:-',
                            isDone: todo.isDone ?? false,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16.8),
                    ),
                    Visibility(
                        visible: _listData
                            .where((element) => element.status == 3)
                            .toList()
                            .isEmpty,
                        child: const Text('No data'))
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
