import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.5,
      alignment: Alignment.centerLeft,
      child: Text(text, style: TextStyle(fontSize: 24, color: Colors.white)),
    );
  }
}
