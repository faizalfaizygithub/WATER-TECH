import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/view/pages/On_Board_Page/on_board_page.dart';
import 'package:water_tech/view/tools/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const OnBoardingPage(),
    );
  }
}
