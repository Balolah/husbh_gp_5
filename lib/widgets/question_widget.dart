import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
  }) : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        ' $question',
        style: const TextStyle(
          fontSize: 33.0,
          fontFamily: 'ReadexPro',
          color: Color.fromARGB(221, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
