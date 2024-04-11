import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:water_tech/controller/onBoardController.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class MyOnBoardTile extends StatelessWidget {
  String? title;
  String? caption;
  String? imagePath;
  MyOnBoardTile({super.key, this.imagePath, this.title, this.caption});
  final onBcontroller = Get.put(OnBoardController().onboardList);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title!,
            style: BlueheadingStyle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              caption!,
              style: greySmalltext,
            ),
          ),
        ],
      ),
    );
  }
}
