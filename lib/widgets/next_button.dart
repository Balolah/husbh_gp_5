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
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(17),
        //padding: const EdgeInsets.symmetric(vertical: 5.0),
        width: 100.0,
        height: 70.0,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              //color: Color.fromARGB(255, 205, 144, 0),
              color: Color(0xFF3489e9),
              offset: Offset(2, 5),
            ),
          ],
          //color: Colors.amber,
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: const Text(
          'تخطي',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "ReadexPro",
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
