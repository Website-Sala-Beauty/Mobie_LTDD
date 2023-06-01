import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoaap_cuoiki/services/local/shared_perferences.dart';

import '../components/app_color.dart';
import '../components/search_box.dart';
import '../components/todo_item.dart';

import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  _getToDo() {
    _prefs.getTodo().then((value) {
      setState(() {
        // chỉ cần gán _listData = value với nhứn todo isDone = true
        if (value != null) {
          _listData = value.toList(); // danh sách gốc để thực hiện cập nhật lại
          _searches =
              [..._listData].where((element) => element.status == 1).toList();
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
                        return TodoItem(
                          onTap: () {
                            setState(() {
                              todo.isDone = true;
                              todo.status = 2;
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
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 14.6,
            child: Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: _showAddBox,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5.6),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.blue),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColor.shadow,
                            offset: Offset(0.0, 3.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _addController,
                        focusNode: _addFocus,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a new todo item',
                          hintStyle: TextStyle(color: AppColor.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18.0),
                GestureDetector(
                  onTap: () {
                    _showAddBox = !_showAddBox;

                    if (_showAddBox) {
                      setState(() {});
                      _addFocus.requestFocus();
                      return;
                    }

                    String text = _addController.text.trim();
                    if (text.isEmpty) {
                      setState(() {});
                      FocusScope.of(context).unfocus();
                      return;
                    }

                    int id = 1;
                    if (todos.isNotEmpty) {
                      id = (todos.last.id ?? 0) + 1;
                    }
                    TodoModel todo = TodoModel()
                      ..id = id
                      ..text = text;
                    _listData.add(todo);
                    _prefs.addBills(_listData);
                    _addController.clear();
                    _searchController.clear();
                    _searchTodos('');
                    setState(() {});
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14.6),
                    decoration: BoxDecoration(
                      color: Colors.amber[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadow,
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add,
                        size: 32.0, color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
