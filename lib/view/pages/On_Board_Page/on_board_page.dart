import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/controller/onBoardController.dart';
import 'package:water_tech/view/pages/AutenticationPages/signup_page.dart';
import 'package:water_tech/view/tools/MyDot_indicator.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/myOnboardTile.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final onBcontroller = Get.put(OnBoardController().onboardList);

  int _pageIndex = 0;

  //define timer Object

  Timer? _timer;

  //page controller

  late PageController _pageController;
  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    // autoscroll

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageIndex < 3) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }
      _pageController.animateToPage(_pageIndex,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                controller: _pageController,
                itemCount: onBcontroller.length,
                itemBuilder: (context, index) {
                  final onBoardData = onBcontroller[index];
                  return MyOnBoardTile(
                    imagePath: onBoardData.imagePath,
                    title: onBoardData.title,
                    caption: onBoardData.caption,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  onBcontroller.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: MyDotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkResponse(
            splashColor: Colors.blue.shade100,
            onTap: () {
              Get.to(SignUpPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(15)),
                height: 50,
                width: 250,
                child: Center(
                  child: Text(
                    'Get Started',
                    style: buttonStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
