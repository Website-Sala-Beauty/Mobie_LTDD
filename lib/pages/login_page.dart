// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/components/custom_button.dart';
import 'package:todoaap_cuoiki/components/custom_text_field.dart';
import 'package:todoaap_cuoiki/components/master-page.dart';
import 'package:todoaap_cuoiki/models/User.dart';
import 'package:todoaap_cuoiki/pages/home-page.dart';
import 'package:todoaap_cuoiki/pages/log_and_reg.dart';
import 'package:todoaap_cuoiki/pages/sign_up.dart';
import 'package:todoaap_cuoiki/pages/splash_page.dart';
// import 'package:roome_app/components/custom_button.dart';
// import 'package:roome_app/components/custom_text_field.dart';
// import 'package:roome_app/page/home_page.dart';
// import 'package:roome_app/page/log_and_reg.dart';
// import 'package:roome_app/page/sign_up.dart';
// import 'package:roome_app/page/splash_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool userCheck = false;
  bool passCheck = false;
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginAndRegister(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: 'MajoraBold',
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              primary: Color(0xFF1178F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Image(
                                  image:
                                      AssetImage('assets/images/logo_face.png'),
                                  height: 30,
                                ),
                                Text(
                                  'Facebook',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13),
                              primary: const Color(0xFF00ADEF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Image(
                                  image: AssetImage(
                                      'assets/images/logo_twitter.png'),
                                  height: 30,
                                ),
                                Text(
                                  'Twitter',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          const Text(
                            'or log in with email',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: userController,
                            keyboardType: TextInputType.phone,
                            hintText: 'Phone Number',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: passController,
                            obscureText: _isObscured,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                                icon: Icon(
                                  _isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            elevation: 0,
                            //backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.only(
                                top: 0, left: 5, right: 5, bottom: 0),
                          ),
                          child: const Text(
                            'Forgot your password',
                            //textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        onPressed: () async {
                          String userInput = userController.text.trim();
                          String passInput = passController.text.trim();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (userInput.isEmpty || passInput.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Field can't be empty"),
                              ),
                            );
                          } else {
                            if (prefs.containsKey('user')) {
                              Map<String, dynamic> userJson =
                                  jsonDecode(prefs.getString('user')!);

                              User user = User.fromJson(userJson);

                              if (userInput == user.phone &&
                                  passInput == user.password) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterPage()),
                                    (route) => false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Logged in successfully'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Wrong password or phone'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No user found'),
                                ),
                              );
                            }
                          }
                        },
                        text: 'Log in'),
                    // const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Color(0xFF57D2C1)),
                  ),
                ),
              ],
            ),
          )
        ],
        // padding: EdgeInsets.symmetric(horizontal: 35),
        // color: Color(0xFFF6F6F6),
      ),
    );
  }
}
