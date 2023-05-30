import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/pages/home_page.dart';

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
      const Duration(seconds: 5),
      () {
        Route route = MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
        Navigator.push(context, route);
      },
    );
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
