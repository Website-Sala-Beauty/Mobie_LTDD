import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/pages/get_started.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //xóa dòng debug
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //điệp
      // home: HomePage(),

      //toản
      home: GetStartedPage(),
    );
  }
}
