import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/controller/Authentication/firebase_auth_services.dart';
import 'package:water_tech/view/pages/AutenticationPages/login_Page.dart';
import 'package:water_tech/view/pages/mainPage.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/myTextField.dart';
import 'package:water_tech/view/tools/my_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode userNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                style: WhiteheadingStyle,
              ),
              Text('Signup your Account to access  \n our service..',
                  style: whiteSmalltext),
              _image(),
              Column(
                children: [
                  CustomTextField(
                    focusNode: userNode,
                    controller: _usernameController,
                    obscuretext: false,
                    labeltxt: 'Username',
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    obscuretext: false,
                    labeltxt: 'Email',
                    icon: Icons.email,
                  ),
                  CustomTextField(
                      controller: _passwordController,
                      obscuretext: false,
                      labeltxt: 'Password',
                      icon: Icons.lock),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  txt: 'Create Account',
                  ontap: () {
                    _signUp();
                  }),
              const SizedBox(
                height: 30,
              ),
              Text(
                '-------------- Or Register with ---------------',
                style: blacksmalltext,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  authButtons(
                    'assets/auth/google.jpg',
                    () => FirebaseAuthService().signInWithGoogle(),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  authButtons('assets/auth/fb.png', () {})
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                        Get.to(const LoginPage(),
                            transition: Transition.zoom,
                            duration: const Duration(seconds: 2));
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

  void _signUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user =
          await _auth.SignUpWithEmailAndPassword(email, password, username);

      if (user != null) {
        print('User sUccesfully created');
        Get.to(const MainPage());
      } else {
        Get.back(canPop: true);
        print('some error happend');
      }
    } catch (e) {
      Get.snackbar('incorrect', '$e');
    }
  }

  void fillthedata() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text(
            'Please enter your details',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ));
        });
  }

  authButtons(String img, Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
                color: Colors.white,
                offset: const Offset(1, 2),
                blurRadius: 2,
                spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        height: 60,
        width: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
