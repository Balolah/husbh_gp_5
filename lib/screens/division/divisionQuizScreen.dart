// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import '../../widgets/next_button.dart';
import '../../widgets/option_card.dart';
import '../home_page.dart';
import 'divisionResultScreen.dart';
import 'dart:async';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:husbh_app/screens/division/divisionResultScreen.dart';
import 'package:just_audio/just_audio.dart';
//for firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class divisionQuizScreen extends StatefulWidget {
  const divisionQuizScreen({Key? key}) : super(key: key);

  @override
  _divisionQuizScreenState createState() => _divisionQuizScreenState();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    TextDirection.rtl;
    return Container();
  }
}

class _divisionQuizScreenState extends State<divisionQuizScreen> {
  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;
  //for firebase
  late User user;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  var id;
  //play audio
  late AudioPlayer player;

  ArabicNumbers arabicNumber = ArabicNumbers();

  List qustions = [];
  List answers = [];
  bool isMarked = false;
  List<List<dynamic>> mcq = [];
  List userAnswer = [];
  var ansData;
  List<dynamic> ans = [];
  var j = 0;
  final int numOfLeval1QuestionsDiv = 4;
  final int numOfLeval2QuestionsDiv = 4;
  final int numOfLeval3QuestionsDiv = 4;

  List<dynamic> Xx = [];

  List<dynamic> Yy = [];
  var divLevel1Score = 0;
  var divLevel2Score = 0;
  var divLevel3Score = 0;
  bool isPressed = false;

  String arabicX = "";
  String arabicY = "";

  var x = Random().nextInt(9) + 1;
  var y = Random().nextInt(9) + 1;

  bool getIsPressed() {
    return isPressed;
  }

  //get isPressed => null;

  // get onPressed => null;

  get startColor => null;

  get endColor => null;

  get borderColor => null;

  get color => null;

  get onPressed => null;

  get states => null;

//returns the value for x
  int getX(QuestionNumber) {
    if (QuestionNumber == 0) {
      x = 0;
    } else if (QuestionNumber == 1) {
      x = 1;
    } else if (QuestionNumber == 2) {
      x = 2;
    } else if (QuestionNumber == 3) {
      x = 3;
    } else if (QuestionNumber == 4) {
      x = 4;
    } else if (QuestionNumber == 5) {
      x = 5;
    } else if (QuestionNumber == 6) {
      x = 6;
    } else if (QuestionNumber == 7) {
      x = 7;
    } else if (QuestionNumber == 8) {
      x = 8;
    } else if (QuestionNumber == 9) {
      x = 9;
    } else if (QuestionNumber == 10) {
      x = 10;
    } else if (QuestionNumber == 11) {
      x = Random().nextInt(2) +
          8; //becaue in the third level we only have 3 values (8-9-10) and the fourth question will either repeat (8-9-10)
    }
    return x;
  }

  void initState() {
    //for firebase
    onRefresh(FirebaseAuth.instance.currentUser);
    getCurrentUser();
    player = AudioPlayer();

    TextDirection.rtl;
    super.initState();

    for (var i = 1; i < numOfLeval1QuestionsDiv + 1; i++) {
      ans = [];
      x = getX(i - 1);
      if (x == 0) {
        y = Random().nextInt(11) + 1;

        while (x % y != 0) y = Random().nextInt(11) + 1;
      } else if (x == 1 || x == 2 || x == 3) {
        y = Random().nextInt(11) + 1;
        while (y % x != 0) y = Random().nextInt(11) + 1;
      }

      Xx.add(x);
      Yy.add(y);

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      if (x == 0) {
        answers.add(x ~/ y);
        ansData = [
          convertOptionsToArabic(x ~/ y),
          convertOptionsToArabic(x ~/ y + 1),
          convertOptionsToArabic(x ~/ y + 7),
          convertOptionsToArabic(x ~/ y + 3),
        ];
      } else if (x > y) {
        answers.add(x ~/ y);
        ansData = [
          convertOptionsToArabic(x ~/ y),
          convertOptionsToArabic(x ~/ y + 1),
          convertOptionsToArabic(x ~/ y + 7),
          convertOptionsToArabic(x ~/ y + 3),
        ];
      } else {
        answers.add(y ~/ x);
        ansData = [
          convertOptionsToArabic(y ~/ x),
          convertOptionsToArabic(y ~/ x + 1),
          convertOptionsToArabic(y ~/ x + 7),
          convertOptionsToArabic(y ~/ x + 3),
        ];
      }

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }

    for (var i = 1; i < numOfLeval2QuestionsDiv + 1; i++) {
      ans = [];
      x = getX(i + 3);
      // x = Random().nextInt(9) + 1;

      if (x == 4) {
        y = Random().nextInt(39) + 1;
        while (y % x != 0) {
          y = Random().nextInt(39) + 1;
        }
      } else if (x == 5) {
        y = Random().nextInt(49) + 1;
        while (y % x != 0) {
          y = Random().nextInt(49) + 1;
        }
      } else if (x == 6) {
        y = Random().nextInt(59) + 1;
        while (y % x != 0) {
          y = Random().nextInt(59) + 1;
        }
      } else if (x == 7) {
        y = Random().nextInt(69) + 1;
        while (y % x != 0) {
          y = Random().nextInt(69) + 1;
        }
      }

      Xx.add(x);

      Yy.add(y);

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      if (x > y) {
        answers.add(x ~/ y);
        ansData = [
          convertOptionsToArabic(x ~/ y),
          convertOptionsToArabic(x ~/ y + 2),
          convertOptionsToArabic(x ~/ y + 9),
          convertOptionsToArabic(x ~/ y + 5),
        ];
      } else {
        answers.add(y ~/ x);
        ansData = [
          convertOptionsToArabic(y ~/ x),
          convertOptionsToArabic(y ~/ x + 2),
          convertOptionsToArabic(y ~/ x + 9),
          convertOptionsToArabic(y ~/ x + 5),
        ];
      }

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }

    for (var i = 1; i < numOfLeval3QuestionsDiv + 1; i++) {
      ans = [];
      x = getX(i + 7);

      if (x == 8) {
        y = Random().nextInt(79) + 1;
        while (y % x != 0) {
          y = Random().nextInt(79) + 1;
        }
      } else if (x == 9) {
        y = Random().nextInt(89) + 1;
        while (y % x != 0) {
          y = Random().nextInt(89) + 1;
        }
      } else if (x == 10) {
        y = Random().nextInt(99) + 1;
        while (y % x != 0) {
          y = Random().nextInt(99) + 1;
        }
      }

      Xx.add(x);

      Yy.add(y);

      // x = Random().nextInt(9) + 1;
      y = Random().nextInt(99) + 1;
      while (x % y != 0) y = Random().nextInt(99) + 1;

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      if (x > y) {
        answers.add(x ~/ y);
        ansData = [
          convertOptionsToArabic(x ~/ y),
          convertOptionsToArabic(x ~/ y + 1),
          convertOptionsToArabic(x ~/ y + 3),
          convertOptionsToArabic(x ~/ y + 6),
        ];
      } else {
        answers.add(y ~/ x);
        ansData = [
          convertOptionsToArabic(y ~/ x),
          convertOptionsToArabic(y ~/ x + 1),
          convertOptionsToArabic(y ~/ x + 3),
          convertOptionsToArabic(y ~/ x + 6),
        ];
      }

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  //for firebase

  onRefresh(userCare) {
    setState(() {
      user = userCare;
    });
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        //  email = signedInUser.email;
        id = signedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }
  /////

  String convertToArabic() {
    arabicX = arabicNumber.convert(x);
    arabicY = arabicNumber.convert(y);
    if (x >= y) {
      return "$arabicX  " + "÷" + "  $arabicY ";
    } else if (x < y) {
      return "$arabicY  " + "÷" + "  $arabicX ";
    } else
      return "  ";
  }

  String convertOptionsToArabic(int num) {
    arabicX = arabicNumber.convert(num);

    return "$arabicX";
  }

  _changeQuestion(ans) {
    userAnswer.add(ans);

    if (j + 1 >= 12) {
      for (var i = 0; i < 4; i++) {
        if (userAnswer[i].toString() ==
            convertOptionsToArabic(answers[i]).toString()) {
          divLevel1Score++;
        }
      }

      for (var i = 4; i < 8; i++) {
        if (userAnswer[i].toString() ==
            convertOptionsToArabic(answers[i]).toString()) {
          divLevel2Score++;
        }
      }

      // var Hundredscore = 0;
      for (var i = 8; i < 12; i++) {
        if (userAnswer[i].toString() ==
            convertOptionsToArabic(answers[i]).toString()) {
          divLevel3Score++;
        }
      }
      Map<String, dynamic> level1 = {
        'score': divLevel1Score,
        'year': year(),
        'time': time(),
      };
      Map<String, dynamic> level2 = {
        'score': divLevel2Score,
        'year': year(),
        'time': time(),
      };
      Map<String, dynamic> level3 = {
        'score': divLevel2Score,
        'year': year(),
        'time': time(),
      };

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Score')
          .doc('Div')
          .update({
        'divLevel1': FieldValue.arrayUnion([level1]),
        'divLevel2': FieldValue.arrayUnion([level2]),
        'divLevel3': FieldValue.arrayUnion([level3]),
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => divisionResultScreen(
              maxLevel1ScoreDiv: numOfLeval1QuestionsDiv,
              maxLevel2ScoreDiv: numOfLeval2QuestionsDiv,
              maxLevel3ScoreDiv: numOfLeval3QuestionsDiv,
              divlevel1Score: divLevel1Score,
              divlevel2Score: divLevel2Score,
              divlevel3Score: divLevel3Score,
              answers: answers,
              qustions: qustions,
              userAnswer: userAnswer),
        ),
      );
      player.setAsset('assets/your_score.mp3');
      player.play();
    } else {
      setState(() {
        ++j;
        isMarked = false;
        isPressed = false;
      });
    }
  }

  //objects for questions
  List<String> objects = [
    'images/house.png',
    'images/bird.png',
    'images/Xhouse.png',
    'images/Xbird.png',
  ];

//returns images for value x (houses)
  Widget _printImageX(xValue) {
    //if value = 0 show its image
    if (xValue == 0) {
      // return Center(
      //   child: Text(""),
      // );
      return Center(
        child: Wrap(
          // direction: Axis.horizontal,
          children: <Widget>[
            // for (var i = 0; i < xValue; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // for (var i = 0; i < yValue; i++)
                Image.asset(
                  objects[2],
                  width: width * 0.09,
                  height: height * 0.15,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.25,
            ),
          ],
        ),
      );
    }
    //else show the apples
    return Center(
      child: Wrap(
        // direction: Axis.horizontal,
        children: <Widget>[
          // for (var i = 0; i < xValue; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              for (var i = 0; i < xValue; i++)
                Image.asset(
                  objects[0],
                  width: width * 0.09,
                  height: height * 0.15,
                ),
            ],
          ),
        ],
      ),
    );
  }

//returns images for value y (birds)
  Widget _printImageY(yValue) {
    if (yValue == 0) {
      return Center(
        child: Text(""),
      );
    }
    return Center(
      child: Wrap(
        // direction: Axis.horizontal,
        children: <Widget>[
          // for (var i = 0; i < xValue; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var i = 0; i < yValue; i++)
                Image.asset(
                  objects[1],
                  width: width * 0.09,
                  height: height * 0.15,
                ),
            ],
          ),
          SizedBox(
            height: height * 0.25,
          ),
        ],
      ),
    );
  }

  // Widget _printImageX(xValue, yValue) {
  //   //if value = 0 show nothing
  //   if (xValue == 0) {
  //     return Center(
  //       child: SizedBox(height: height * 0.0001, child: Text("")),
  //     );
  //   } else
  //   //  if (xValue > yValue)
  //   //else show the birds
  //   {
  //     return Center(
  //       child: Wrap(
  //         // direction: Axis.horizontal,
  //         children: <Widget>[
  //           // for (var i = 0; i < xValue; i++)
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             // mainAxisSize: MainAxisSize.max,
  //             children: [
  //               for (var i = 0; i < xValue; i++)
  //                 Image.asset(
  //                   objects[1],
  //                   width: width * 0.09,
  //                   height: height * 0.15,
  //                 ),
  //             ],
  //           )
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Widget _printImageY(xValue, yValue) {
  //   //if value = 0 show nothing
  //   if (yValue == 0) {
  //     return Center(
  //       child: SizedBox(height: height * 0.0001, child: Text("")),
  //     );
  //   } else
  //   // if(xValue>yValue)
  //   //else show the birds
  //   {
  //     return Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         // mainAxisSize: MainAxisSize.max,
  //         children: [
  //           for (var i = 0; i < yValue; i++)
  //             Image.asset(
  //               objects[1],
  //               width: width * 0.09,
  //               height: height * 0.15,
  //             ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  void nextQuestion() {
    _changeQuestion('-١');
  }

  void changeColor() {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    textDirection:
    TextDirection.rtl;
    return Scaffold(
      body: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/farm.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(qustions[j],
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.lightBlue,
                          fontFamily: "ReadexPro-Regular",
                          fontSize:
                              MediaQuery.of(context).size.width > 500 ? 45 : 20,
                          fontWeight: FontWeight.bold)),
                ),
                ImagesUnderQuestion(j),
                // SizedBox(
                //   height: height * 0.14,
                // ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  SizedBox(
                    height: height * 0.155,
                    width: width * 0.13,
                    child: OptionCard(
                        option: mcq[j][0].toString(),
                        color: isPressed
                            ? (mcq[j][0].toString() ==
                                    convertOptionsToArabic(answers[j])
                                        .toString())
                                ? const Color.fromARGB(
                                    255, 50, 132, 9) //correct
                                : const Color.fromRGBO(
                                    218, 39, 39, 1) //incorrect
                            : const Color(0xFF3489e9),
                        onTap: () async {
                          if (mcq[j][0].toString() ==
                              convertOptionsToArabic(answers[j]).toString()) {
                            await player.setAsset('assets/good_job.mp3');
                            player.play();
                          } else {
                            await player.setAsset('assets/wrong_answer.mp3');
                            player.play();
                          }
                          changeColor();
                          //await
                          await Future.delayed(const Duration(seconds: 4), () {
                            _changeQuestion(mcq[j][0].toString());
                          });
                        }),
                  ),
                  SizedBox(height: height * 0.20, width: width * 0.03),
                  SizedBox(
                    height: height * 0.155,
                    width: width * 0.13,
                    child: OptionCard(
                        option: mcq[j][1].toString(),
                        color: isPressed
                            ? (mcq[j][1].toString() ==
                                    convertOptionsToArabic(answers[j])
                                        .toString())
                                ? const Color.fromARGB(
                                    255, 50, 132, 9) //correct
                                : const Color.fromRGBO(
                                    218, 39, 39, 1) //incorrect
                            : const Color(0xFF3489e9),
                        onTap: () async {
                          if (mcq[j][1].toString() ==
                              convertOptionsToArabic(answers[j]).toString()) {
                            await player.setAsset('assets/good_job.mp3');
                            player.play();
                          } else {
                            await player.setAsset('assets/wrong_answer.mp3');
                            player.play();
                          }
                          changeColor();
                          //await
                          await Future.delayed(const Duration(seconds: 4), () {
                            _changeQuestion(mcq[j][1].toString());
                          });
                        }),
                  ),
                  SizedBox(height: height * 0.20, width: width * 0.03),
                  SizedBox(
                    height: height * 0.155,
                    width: width * 0.13,
                    child: OptionCard(
                        option: mcq[j][2].toString(),
                        color: isPressed
                            ? (mcq[j][2].toString() ==
                                    convertOptionsToArabic(answers[j])
                                        .toString())
                                ? const Color.fromARGB(
                                    255, 50, 132, 9) //correct
                                : const Color.fromRGBO(
                                    218, 39, 39, 1) //incorrect
                            : const Color(0xFF3489e9),
                        onTap: () async {
                          if (mcq[j][2].toString() ==
                              convertOptionsToArabic(answers[j]).toString()) {
                            await player.setAsset('assets/good_job.mp3');
                            player.play();
                          } else {
                            await player.setAsset('assets/wrong_answer.mp3');
                            player.play();
                          }
                          changeColor();
                          //await
                          await Future.delayed(const Duration(seconds: 4), () {
                            _changeQuestion(mcq[j][2].toString());
                          });
                        }),
                  ),
                  SizedBox(height: height * 0.20, width: width * 0.03),
                  SizedBox(
                    height: height * 0.155,
                    width: width * 0.13,
                    child: OptionCard(
                        option: mcq[j][3].toString(),
                        color: isPressed
                            ? (mcq[j][3].toString() ==
                                    convertOptionsToArabic(answers[j])
                                        .toString())
                                ? const Color.fromARGB(
                                    255, 50, 132, 9) //correct
                                : const Color.fromRGBO(
                                    218, 39, 39, 1) //incorrect
                            : const Color(0xFF3489e9),
                        onTap: () async {
                          if (mcq[j][3].toString() ==
                              convertOptionsToArabic(answers[j]).toString()) {
                            await player.setAsset('assets/good_job.mp3');
                            player.play();
                          } else {
                            await player.setAsset('assets/wrong_answer.mp3');
                            player.play();
                          }
                          changeColor();
                          //await
                          await Future.delayed(const Duration(seconds: 4), () {
                            _changeQuestion(mcq[j][3].toString());
                          });
                        }),
                  ),
                  SizedBox(height: height * 0.20, width: width * 0.03),
                ]),
              ])
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30,top: 30,right: 10),
        child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                  FloatingActionButton( 
                       backgroundColor:Colors.transparent,      
                     child: Icon(
                        
                        //icon: Icon(Icons.arrow_back_ios),
                        Icons.home_rounded,
                        color: Colors.brown.shade600,
                        //color: Colors.blue,
                        size: 60.0,
                      ),
                      
          heroTag: null, 
                         onPressed: () { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => home_page()),
                          );
                        },
        ),
        Expanded(child: Container()),
             
             Container(
                height: 70.0,
                width: 100.0,
                
               child: FloatingActionButton(
                backgroundColor: Colors.transparent, 
                       child: Column(
                        
                        children: <Widget>[NextButton(nextQuestion: nextQuestion)]),
                    
                    onPressed: () {
                    

                  },
                    heroTag: null,
                  ),
             ), ]
          ),
      )
    );
  }

  String strReturned() {
    String str = "";
    if (qustions[j].toString().substring(4, 5) == "÷") {
      str = qustions[j].toString().substring(5);
    } else {
      str = qustions[j].toString().substring(4);
    }
    return str;
  }

  // ignore: non_constant_identifier_names
  ImagesUnderQuestion(int j) {
    // if (j < 11) {
    if (j == 0 || j == 1 || j == 2 || j == 3) {
      // return Expanded(
      //   child: SizedBox(
      //     height: double.infinity,
      //     child: Stack(
      //       fit: StackFit.expand,
      //       alignment: Alignment.topCenter,
      //       children: <Widget>[
      //         new Positioned(
      //           top: 1,
      //           // left: 2,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             mainAxisSize: MainAxisSize.max,
      //             children: [
      //               // SizedBox(
      //               //   // height: height * 0.90,
      //               //   child: Expanded(
      //               //     // flex: 2,
      //               //     child: Image.asset(
      //               //       'images/birdHousee.png',
      //               //       height: height * 0.60,
      //               //     ),
      //               //   ),
      //               // ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           // child: new Positioned(
      //           //   top: 80,
      //           //   left: 285,
      //           height: height * 0.05,

      //           child: _printImageX(Xx[j]),
      //           // ),
      //         ),
      //         SizedBox(
      //           height: height * 0.20,
      //         ),
      //         SizedBox(
      //           // child: new Positioned(
      //           //   top: 80,
      //           //   left: 285,
      //           height: height * 0.05,
      //           child: _printImageY(Yy[j]),
      //           // ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
      //////////////////////////////////////
      return SizedBox(
        height: height * 0.55,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              SizedBox(child: _printImageY(Yy[j])),
              SizedBox(child: _printImageX(Xx[j])),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: height * 0.56,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.37,
                            // height: height * 0.2,
                            child: Text(
                              "  ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: width * 0.05,
                                  height: height * 0.55,
                                  child: Text(
                                    strReturned(),
                                    // qustions[j].toString().substring(4),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.15,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: width * 0.23,
                                child: Text(
                                  qustions[j].toString().substring(0, 2),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/division.png',
                      height: height * 0.55,
                      width: width * 0.38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  String year() {
    var y = replaceFarsiNumber(DateTime.now().year.toString());
    var m = replaceFarsiNumber(DateTime.now().month.toString());
    var d = replaceFarsiNumber(DateTime.now().day.toString());

    var year = d + '/' + m + '/' + y;

    return year;
  }

  String time() {
    var h = replaceFarsiNumber(DateTime.now().hour.toString());
    var min = replaceFarsiNumber(DateTime.now().minute.toString());
    var s = replaceFarsiNumber(DateTime.now().second.toString());

    if (h == '۱۲') {
      h = h + " مساءً ";
    } else if (h == '۱۳') {
      h = '۰۱';
      h = h + " مساءً ";
    } else if (h == '۱٤') {
      h = '۰۲';
      h = h + " مساءً ";
    } else if (h == '۱٥') {
      h = '۰۳';
      h = h + " مساءً ";
    } else if (h == '۱٦') {
      h = '۰٤';
      h = h + " مساءً ";
    } else if (h == '۱٧') {
      h = '۰٥';
      h = h + " مساءً ";
    } else if (h == '۱۸') {
      h = '۰٦';
      h = h + " مساءً ";
    } else if (h == '۱۹') {
      h = '۰٧';
      h = h + " مساءً ";
    } else if (h == '۲۰') {
      h = '۰۸';
      h = h + " مساءً ";
    } else if (h == '۲۱') {
      h = '۰۹';
      h = h + " مساءً ";
    } else if (h == '۲۲') {
      h = '۱۰';
      h = h + " مساءً ";
    } else if (h == '۲۳') {
      h = '۱۱';
      h = h + " مساءً ";
    } else if (h == '۰') {
      h = '۰۰';
      h = h + " صباحًا ";
    } else {
      h = h + " صباحًا ";
    }

    if (min == '۰') {
      min = "۰۰";
    } else if (min == '۱') {
      min = '۰۱';
    } else if (min == '۲') {
      min = '۰۲';
    } else if (min == '۳') {
      h = '۰۳';
    } else if (min == '٤') {
      min = '۰٤';
    } else if (min == '٥') {
      min = '۰٥';
    } else if (min == '٦') {
      min = '۰٦';
    } else if (min == '٧') {
      min = '۰٧';
    } else if (min == '۸') {
      min = '۰۸';
    } else if (min == '۹') {
      min = '۰۹';
    }
    if (s == '۰') {
      s = "۰۰";
    } else if (s == '۱') {
      s = '۰۱';
    } else if (s == '۲') {
      s = '۰۲';
    } else if (s == '۳') {
      s = '۰۳';
    } else if (s == '٤') {
      s = '۰٤';
    } else if (s == '٥') {
      s = '۰٥';
    } else if (s == '٦') {
      s = '۰٦';
    } else if (s == '٧') {
      s = '۰٧';
    } else if (s == '۸') {
      s = '۰۸';
    } else if (s == '۹') {
      s = '۰۹';
    }

    var time = s + ' : ' + min + ' : ' + h;
    DateTime now = new DateTime.now();
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime
    print(DateTime.now().toLocal());
    return time;
  }
}
