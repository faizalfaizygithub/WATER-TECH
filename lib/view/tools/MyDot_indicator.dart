import 'package:flutter/material.dart';

class MyDotIndicator extends StatelessWidget {
  bool isActive;
  MyDotIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
          border: isActive ? null : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Colors.blue : Colors.grey),
    );
  }
}
