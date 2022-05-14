import 'package:flutter/material.dart';
// import 'package:fabexdateformatter/fabexdateformatter.dart';

class QuizButtonIcon extends StatelessWidget {
  final String option;

  const QuizButtonIcon({required this.option});
  @override
  Widget build(BuildContext context) {
    textDirection:
    TextDirection.rtl;
    return Container(
      child: Center(
          child: Text(option,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontFamily: "ReadexPro",
                  fontSize: 25))),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width > 550
          ? 200
          : MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width > 550
          ? 50
          : MediaQuery.of(context).size.width / 7,
    );
  }
}
