import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          _firstStack(),
          _image(),
          Positioned(
            child: Container(
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  _firstStack() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight),
      ),
    );
  }

  _image() {
    return Positioned(
        left: 20,
        right: 20,
        top: 50,
        bottom: 300,
        child: Image.asset(
          'assets/auth/signup.png',
          fit: BoxFit.cover,
        ));
  }
}
