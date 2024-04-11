import 'package:flutter/material.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class MyButton extends StatelessWidget {
  final String txt;
  final Function() ontap;
  const MyButton({
    super.key,
    required this.txt,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.blue.shade500,
      onTap: ontap,
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
              txt,
              style: buttonStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
