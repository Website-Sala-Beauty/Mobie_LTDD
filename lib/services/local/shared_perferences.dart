import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/models/todo_model.dart';

class SharePrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<TodoModel>?> getTodo() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('listTodo');
    if (data == null) return null;

    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>; // cast để chuyển đổi kiểu dữ liệu
    List<TodoModel> bills = maps.map((e) => TodoModel.fromJson(e)).toList();
    return bills;
  }

  Future<void> addBills(List<TodoModel> bills) async {
    List<Map<String, dynamic>> maps = bills.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('listTodo', jsonEncode(maps));
  }
}
