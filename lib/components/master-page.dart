import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/components/todo_app_bar.dart';
import 'package:todoaap_cuoiki/pages/home-page.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';
import 'package:todoaap_cuoiki/pages/todo-delete.dart';
import 'package:todoaap_cuoiki/pages/todo-finish.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ToDoFinshPage(),
    ToDoDeletePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Bạn có chắc chắn muốn đăng xuất?',
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
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove('user');
                      Route route = MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                        context,
                        route,
                        (Route<dynamic> route) => false,
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
      body: Center(
        //child: widget.child,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'Finish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_delete_rounded),
            label: 'Delete',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
