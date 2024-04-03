import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/view/pages/AutenticationPages/login_Page.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/myTextField.dart';
import 'package:water_tech/view/tools/my_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              begin: Alignment.topCenter,
              end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Let's Get Started",
                style: BheadingStyle,
              ),
              Text('Signup your Account to access  \n our service..',
                  style: smalltext),
              _image(),
              Column(
                children: [
                  CustomTextField(
                    obscuretext: false,
                    labeltxt: 'Username',
                    icon: Icons.person,
                  ),
                  CustomTextField(
                      obscuretext: false, labeltxt: 'Email', icon: Icons.email),
                  CustomTextField(
                      obscuretext: false,
                      labeltxt: 'Password',
                      icon: Icons.lock),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(txt: 'Create Account', ontap: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.to(const LoginPage());
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
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
      'assets/auth/signup.png',
      fit: BoxFit.cover,
    );
  }
}
