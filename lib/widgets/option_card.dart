import 'dart:ui';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard(
      {Key? key,
      required this.option,
      required this.color,
      required this.onTap})
      : super(key: key);

  final String option;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        child: Container(
          width: 68,
          height: 60,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 0, 61, 175),
              offset: Offset(3, 4),
            ),
          ], color: color, borderRadius: BorderRadius.circular(70)),
          child: Center(
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontFamily: 'ReadexPro',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
