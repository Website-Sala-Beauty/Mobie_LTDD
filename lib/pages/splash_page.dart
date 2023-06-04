// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/components/master-page.dart';
import 'package:todoaap_cuoiki/pages/home-page.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        checkLogin();
      },
    );
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MasterPage()),
      );
    } else {
      // Không có thông tin đăng nhập, chuyển hướng đến màn hình đăng nhập
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/load.gif',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Positioned.fill(

          // ),
        ],
      ),
    );
  }
}
