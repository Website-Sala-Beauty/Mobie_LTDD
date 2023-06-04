import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/components/custom_button.dart';
import 'package:todoaap_cuoiki/components/custom_text_field.dart';
import 'package:todoaap_cuoiki/models/User.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passConfirmController = TextEditingController();

  TextEditingController passController = TextEditingController();
  bool _isObscured = true;
  bool _isObscuredConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
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
                height: MediaQuery.of(context).size.height * 1.1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                            fontFamily: 'MajoraBold',
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 15),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Form(
                          child: Column(
                            children: [
                              const Text(
                                'or sign up with email',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextField(
                                controller: passController,
                                obscureText: _isObscured,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Password',
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
                                      color: Color.fromARGB(255, 114, 228, 243),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: passConfirmController,
                                obscureText: _isObscuredConfirm,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscuredConfirm =
                                            !_isObscuredConfirm;
                                      });
                                    },
                                    icon: Icon(
                                      _isObscuredConfirm
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromARGB(255, 114, 228, 243),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                          onPressed: () async {
                            String password = passController.text;

                            if (checkNull(password)) {
                              if (passConfirmController.text ==
                                  passController.text) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                  Map<String, dynamic> userJson = jsonDecode(prefs.getString('user')!);
                                User use = User.fromJson(userJson);
                                User use2 = User(
                                  name: use.name,
                                  password: passController.text,
                                  phone: use.phone
                                );
                                prefs.setString('user', use2.toJson());
                                SnackBar snackBar = const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      'Đổi mật khẩu thành công',
                                      style: TextStyle(color: Colors.white),
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              } else {
                                showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      '!!!!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content: Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Mật khẩu không khớp',
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
                              }
                            } else {
                              // showAlertDialog(context);

                              showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    '!!!!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Vui lòng nhập đầy đủ thông tin',
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
                            }
                          },
                          text: 'Reset Password'),
                      const SizedBox(height: 15),

                      const Center(
                        child: Text(
                          'By signing up, you agreed with our Term of\nServices and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      // const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Color(0xFF57D2C1)),
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

bool checkNull(String password) {
  if (password.isEmpty) {
    return false;
  }

  return true;
}
