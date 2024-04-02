import 'package:flutter/material.dart';
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
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title!,
            style: headingStyle,
          ),
          Text(
            caption!,
            style: subHeadingStyle,
          ),
        ],
      ),
    );
  }
}
