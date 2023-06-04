import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';

import '../components/app_color.dart';
import '../components/search_box.dart';
import '../components/todo_app_bar.dart';
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

  @override
  void initState() {
    super.initState();
    _searches = [...todos];
  }

  _searchTodos(String searchText) {
    searchText = searchText.toLowerCase();
    // _searches.clear();
    // for (var element in todos) {
    //   if ((element.text ?? '').toLowerCase().contains(searchText)) {
    //     _searches.add(element);
    //   }
    // }
    _searches = todos
        .where((element) =>
            (element.text ?? '').toLowerCase().contains(searchText))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppBar(
          rightPressed: () async {
            bool? status = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('😍'),
                content: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Do you want to logout?',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            if (status ?? false) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
          title: ''),
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
                              todo.isDone = !(todo.isDone ?? false);
                            });
                          },
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
                                todos.remove(todo);
                                _searches.remove(todo);
                              });
                            }
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
                    todos.add(todo);
                    _addController.clear();
                    _searchController.clear();
                    _searchTodos('');
                    setState(() {});
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14.6),
                    decoration: BoxDecoration(
                      color: AppColor.blue,
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
