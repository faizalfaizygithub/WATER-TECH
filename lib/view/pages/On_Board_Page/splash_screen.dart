import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_tech/view/pages/On_Board_Page/on_board_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: const CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(
            'assets/photo/logo1.jpeg',
          ),
        ),
      ),
    );
  }
}
