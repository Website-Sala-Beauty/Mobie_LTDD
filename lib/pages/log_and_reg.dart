import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/components/custom_button.dart';
import 'package:todoaap_cuoiki/pages/login_page.dart';
import 'package:todoaap_cuoiki/pages/sign_up.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                  items: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/log_a_reg_1.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/log_a_reg_2.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/log_a_reg_3.jpg'),
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                  )),
              const SizedBox(height: 15),
              Text(
                'Plan your trips',
                style: TextStyle(
                    fontFamily: 'MajoraBold',
                    fontSize: 28,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),
              Text(
                'Book one of out unique hotel to\nescape the ordinary',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade900),
              ),
              const SizedBox(height: 40),
              CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  text: 'Log in'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 85, vertical: 0),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4,
                    shadowColor: Colors.grey,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child:const Text(
                      'Create account',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
