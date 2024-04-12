import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/controller/firebase_auth_services.dart';
import 'package:water_tech/view/pages/AutenticationPages/signup_page.dart';
import 'package:water_tech/view/pages/mainPage.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/myTextField.dart';
import 'package:water_tech/view/tools/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Timer _timer = Timer(const Duration(seconds: 2), () {});
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Welcome Back',
                style: WhiteheadingStyle,
              ),
              Text('Login to your existing account', style: greySmalltext),
              _image(),
              Column(
                children: [
                  CustomTextField(
                      controller: _emailController,
                      obscuretext: false,
                      labeltxt: 'Email',
                      icon: Icons.email),
                  CustomTextField(
                    controller: _passwordController,
                    obscuretext: isVisible,
                    labeltxt: 'Password',
                    icon: Icons.lock,
                    suffxicon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible == true
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.blueGrey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.blueGrey,
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget password',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  txt: 'Login',
                  ontap: () {
                    _signIn();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.to(const SignUpPage(),
                            transition: Transition.zoom,
                            duration: Duration(seconds: 2));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _image() {
    return Image.asset(
      'assets/auth/login2.webp',
      fit: BoxFit.cover,
    );
  }

  void wrongEmailOrpasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'incorrect Email or Password',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          );
        });
  }

  void _signIn() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.SignInWithEmailAndPassword(email, password);

      if (user != null) {
        print('User sUccesfully signIN');

        Get.to(MainPage());
      } else {
        wrongEmailOrpasswordMessage();
        Get.back(canPop: true);
      }
    } catch (e) {
      Get.snackbar('incorrect', '$e');
    }
  }
}
