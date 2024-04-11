import 'package:flutter/material.dart';
import 'package:water_tech/model/Service.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class MyServiceListTile extends StatelessWidget {
  final Service service;
  const MyServiceListTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    service.imagePath,
                    fit: BoxFit.cover,
                  )),
            ), //produc
            SizedBox(
              height: 20,
            ),

            Text(
              service.name,
              style: subHeadingStyleBlue,
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(4, 4), blurRadius: 3)
                  ]),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  service.price.toString(),
                  textAlign: TextAlign.center,
                  style: buttonStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
