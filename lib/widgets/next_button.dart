import 'package:flutter/material.dart';
import 'dart:async';

class NextButton extends StatelessWidget {
   const NextButton({Key? key, required this.nextQuestion}) : super(key: key);
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        width: 88.0,
        height: 59.0,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 205, 144, 0),
              offset: Offset(2, 3),
            ),
          ],
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: const Text(
          'التالي',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
