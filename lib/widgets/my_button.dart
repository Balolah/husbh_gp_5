import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {required this.title,
      required this.onPressed,
      required this.startColor,
      required this.endColor,
      required this.borderColor,
      required this.textColor});

  final String title;
  final Function onPressed;
  final Color startColor;
  final Color endColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 150,
      ),
      child: NiceButtons(
        startColor: startColor,
        endColor: endColor,
        borderColor: borderColor,
        height: 50,
        stretch: true,
        gradientOrientation: GradientOrientation.Horizontal,
        onTap: (finish) {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
