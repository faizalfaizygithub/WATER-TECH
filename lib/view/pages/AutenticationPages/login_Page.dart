import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/view/pages/AutenticationPages/signup_page.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/myTextField.dart';
import 'package:water_tech/view/tools/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
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
                style: BheadingStyle,
              ),
              Text('Login to your existing account', style: smalltext),
              _image(),
              Column(
                children: [
                  CustomTextField(
                      obscuretext: false, labeltxt: 'Email', icon: Icons.email),
                  CustomTextField(
                    controller: passwordController,
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
              MyButton(txt: 'Login', ontap: () {}),
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
                        Get.to(const SignUpPage());
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
}
