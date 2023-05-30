import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/pages/log_and_reg.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';
// import 'package:roome_app/page/log_and_reg.dart';
// import 'package:roome_app/page/login_page.dart';

import '../components/custom_button.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/get_started.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              // color: Color(0xFF50D5C0),
              decoration: BoxDecoration(
                color: Color(0xFF57D2C1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.house_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Roome",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontFamily: 'MajoraBold'),
            ),
            const SizedBox(height: 10),
            Text(
              "Best hostel deals for your holiday",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 250),
            CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginAndRegister(),
                    ),
                  );
                },
                text: 'Get Started'),
            const SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
