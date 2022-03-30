// import 'package:flutter/cupertino.dart';

class Question {
  final String id;
  final String title;
  String image;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.image,
  });

  @override
  //to print the questions on console
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
