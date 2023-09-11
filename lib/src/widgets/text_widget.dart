import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;

  TextWidget({
    required this.title,
    required this.fontSize
  }) : assert(title.isNotEmpty == true),
       assert(!fontSize.isNegative == true);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize
      ),
    );
  }
}