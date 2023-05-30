// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoaap_cuoiki/components/custom_button.dart';
import 'package:todoaap_cuoiki/components/custom_text_field.dart';
import 'package:todoaap_cuoiki/models/User.dart';
import 'package:todoaap_cuoiki/pages/log_and_reg.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isObscured = true;

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
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'MajoraBold',
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 15),
                    Row(
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
                            primary: Color(0xFF00ADEF),
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
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          const Text(
                            'or sign up with email',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: firstNameController,
                            hintText: 'Full Name',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: userController,
                            hintText: 'Phone Name',
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
                    const SizedBox(height: 15),
                    CustomButton(
                        onPressed: () async {
                          String firstName = firstNameController.text;
                          String phone = userController.text;
                          String password = passController.text;
                          if (checkNull(firstName, phone, password)) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            User use = User(
                              phone: userController.text,
                              password: passController.text,
                              name: firstNameController.text,
                            );
                            prefs.setString('user', use.toJson());
                            SnackBar snackBar = const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Đăng ký thành công',
                                  style: TextStyle(color: Colors.white),
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
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
                        text: 'Sign Up'),
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

bool checkNull(String firstName, String phone, String password) {
  if (firstName.isEmpty || phone.isEmpty || password.isEmpty) {
    return false;
  }

  return true;
}
