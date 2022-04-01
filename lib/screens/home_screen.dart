import 'dart:io';
import 'package:flutter/material.dart';
import 'Questions.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import 'learn_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_final_fields
  List<Question> _questions = [
    Question(
      id: '1',
      title: '----- =   ٥   +   ٢',
      options: {'٣': false, '٥': false, '٢': false, '٧': true},
      image: 'assets/q1.png',
    ),
    Question(
      id: '2',
      title: '----- =   ٨   +   ٣',
      options: {'٩': false, '٤': false, '١١': true, '٥': false},
      image: 'assets/q2.png',
    ),
    Question(
      id: '3',
      title: '',
      options: {'٥': true, '٩': false, '٨': false, '١١': false},
      image: 'assets/q33.png',
    ),
    Question(
      id: '4',
      title: '',
      options: {'٦': false, '١٠': true, '١٢': false, '٣': false},
      image: 'assets/q44.png',
    ),
    Question(
      id: '5',
      title: '',
      //=   ١٢٣   +   ٢٦١'
      options: {'٥٦': true, '٦٧': false, '٦٠': false, '٤١': false},
      image: 'assets/q55.png',
    ),
    Question(
      id: '6',
      title: '',
      //'=   ١٠٢   +   ١٣٣'v
      options: {'٩٠': false, '٧١': false, '٩٩': true, '٦٨': false},
      image: 'assets/q66.png',
    ),
  ];

//index of the question
  int index = 0;

// //it is false first since no buttons are pressed yet
  bool isPressed = false;

//Not used yet
  bool getIsPressed() {
    return isPressed;
  }

//to display next question
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      setState(() {
        index++;
        isPressed = false;
      });
    }
  }


void lastQuestion(){
    Navigator.push(context, MaterialPageRoute(builder:(context)=>learn_page()));

}

//returns the image of the current question
  String imageExists() {
    return _questions[index].image;
  }

//changes the color of the button
  void chnageColor() {
    setState(() {
      isPressed = true;
    });
  }

// background array
  List<String> images = [
    'assets/farm.jpg',
    'assets/farm.jpg',
    'assets/cloud.jpg',
    'assets/cloud.jpg',
    'assets/lake2.jpg',
    'assets/lake2.jpg',
  ];
  //background method
  String imageName() {
    return images[index];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageName()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
//Row of images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: index < 2
                        ? Padding(
                          
                            padding: const EdgeInsets.only(top: 40.0),
                            child: QuestionWidget(
                              indexAction: index,
                              question: _questions[index].title,
                              totalQuestions: _questions.length,
                            ),
                          )
                        : 2 <= index && index <= 5
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                               
                                child: QuestionWidget(
                                  indexAction: index,
                                  
                                  question: _questions[index].title,
                                  totalQuestions: _questions.length,
                                ),
                              )
                            : const SizedBox(height: 70.0),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: index < 2
                        ? Image(
                            image: AssetImage(imageExists()),
                            width: 500,
                            height: 250,
                            // width: 500,
                            // height: 250,
                          )
                        : 2 <= index && index <= 5
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Image(
                                  image: AssetImage(imageExists()),
                                  width: 350,
                                  height: 250,
                                  // width: 350,
                                  // height: 250,
                                ),
                              )
                            : null,
                    // : const SizedBox(height: 60.0),
                  ),
                ],
              ),

//Row of options for the question (based on the index)
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < _questions[index].options.length; i++)
                        OptionCard(
                            option: _questions[index].options.keys.toList()[i],
                            color: isPressed
                                ? _questions[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? const Color.fromARGB(
                                        255, 50, 132, 9) //correct
                                    : const Color.fromRGBO(
                                        218, 39, 39, 1) //incorrect
                                : const Color(0xFF3489e9),
                            onTap: () async {
                              chnageColor();
                              //await
                              await Future.delayed(const Duration(seconds: 1),
                                  () {
                                    if (index<5)
                                   { 
                                nextQuestion();}
                                else 
                                lastQuestion();
                          
                              });
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
 
//for the Next button

     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          
           child : Column(children:<Widget>[
              
             index<5?
              NextButton (nextQuestion: nextQuestion):
            // nextQuestion: lastQuestion
      NextButton (nextQuestion: lastQuestion)
           ])),
        ),
        
    );
  }
    
}
