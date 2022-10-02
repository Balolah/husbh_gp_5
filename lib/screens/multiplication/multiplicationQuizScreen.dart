import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:husbh_app/main.dart';
import '../../widgets/next_button.dart';
import '../../widgets/option_card.dart';
import 'multiplicationResultScreen.dart';
import 'dart:async';
import '../QuizButtonIcon.dart';
import 'package:husbh_app/screens/QuizButtonIcon.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'multiplication_video.dart';
import 'package:just_audio/just_audio.dart';
//for firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//×
class multiplicationQuizScreen extends StatefulWidget {
  const multiplicationQuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    TextDirection.rtl;
    return Container();
  }
}

class _QuizScreenState extends State<multiplicationQuizScreen> {
  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;

  ArabicNumbers arabicNumber = ArabicNumbers();

  //for firebase
  late User user;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  var id;

  //play audio
  late AudioPlayer player;

  List qustions = [];
  List answers = [];
  bool isMarked = false;
  List<List<dynamic>> mcq = [];
  List userAnswer = [];
  var ansData;
  List<dynamic> ans = [];
  var j = 0;
  final int numOfLevel1QuestionsMul = 4; //(0,1,2,3)
  final int numOfLevel2QuestionsMul = 4; //(4,5,6,7)
  final int numOfLevel3QuestionsMul = 4; //(8,9,10)
  List<dynamic> Xx = [];
  List<dynamic> Yy = [];
  var mulLevel1Score = 0; //(0,1,2,3)
  var mulLevel2Score = 0; //(4,5,6,7)
  var mulLevel3Score = 0; //(8,9,10)
  bool isPressed = false;

  String arabicX = "";
  String arabicY = "";

  var x = Random().nextInt(9) + 1;
  var y = Random().nextInt(9) + 1;

  bool getIsPressed() {
    return isPressed;
  }

  get startColor => null;

  get endColor => null;

  get borderColor => null;

  get color => null;

  get onPressed => null;

  get states => null;

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
//(0,1,2,3)
    for (var i = 1; i < numOfLevel1QuestionsMul + 1; i++) {
      ans = [];
      x = getX(i - 1);
      y = Random().nextInt(11);
      Xx.add(x);
      Yy.add(y);

      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x * y);
      ansData = [
        convertOptionsToArabic(x * y),
        convertOptionsToArabic(x * y + 1),
        convertOptionsToArabic(x * y + 7),
        convertOptionsToArabic(x * y + 3),
      ];

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
//(4,5,6,7)
    for (var i = 1; i < numOfLevel2QuestionsMul + 1; i++) {
      ans = [];
      x = getX(i + 3);
      y = Random().nextInt(11);

      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x * y);
      ansData = [
        convertOptionsToArabic(x * y),
        convertOptionsToArabic(x * y + 2),
        convertOptionsToArabic(x * y + 9),
        convertOptionsToArabic(x * y + 5),
      ];

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
//(8,9,10)
    for (var i = 1; i < numOfLevel3QuestionsMul + 1; i++) {
      ans = [];
      x = getX(i + 7);
      y = Random().nextInt(11);

      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x * y);
      ansData = [
        convertOptionsToArabic(x * y),
        convertOptionsToArabic(x * y + 1),
        convertOptionsToArabic(x * y + 3),
        convertOptionsToArabic(x * y + 6),
      ];

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

    return "$arabicX  " + "×" + "  $arabicY ";
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
          mulLevel1Score++;
        }
      }

      for (var i = 4; i < 8; i++) {
        if (userAnswer[i].toString() ==
            convertOptionsToArabic(answers[i]).toString()) {
          mulLevel2Score++;
        }
      }

      for (var i = 8; i < 12; i++) {
        if (userAnswer[i].toString() ==
            convertOptionsToArabic(answers[i]).toString()) {
          mulLevel3Score++;
        }
      }
      Map<String, dynamic> level1 = {
        'score': mulLevel1Score,
        'year': year(),
        'time': time(),
      };
      Map<String, dynamic> level2 = {
        'score': mulLevel2Score,
        'year': year(),
        'time': time(),
      };
      Map<String, dynamic> level3 = {
        'score': mulLevel2Score,
        'year': year(),
        'time': time(),
      };

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Score')
          .doc('Mul')
          .update({
        'mulLevel1': FieldValue.arrayUnion([level1]),
        'mulLevel2': FieldValue.arrayUnion([level2]),
        'mulLevel3': FieldValue.arrayUnion([level3]),
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => multiplicationResultScreen(
              maxLevel1ScoreMul: numOfLevel1QuestionsMul,
              maxLevel2ScoreMul: numOfLevel2QuestionsMul,
              maxLevel3ScoreMul: numOfLevel3QuestionsMul,
              mullevel1score: mulLevel1Score,
              mullevel2score: mulLevel2Score,
              mullevel3score: mulLevel3Score,
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
    'images/egg.png',
    'images/Xegg.png',
  ];
//returns images for value x
  Widget _printImageX(xValue, yValue) {
    //if value = 0 show its image
    if (xValue == 0) {
      return Center(
        child: Text(""),
      );
    }
    //else show the eggs
    return Center(
      child: Wrap(
        // direction: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < xValue; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var i = 0; i < yValue; i++)
                  Image.asset(
                    objects[0],
                    width: width * 0.06,
                    height: height * 0.09,
                  ),
              ],
            )
        ],
      ),
    );
  }

//returns images for value y
  Widget _printImageY(yValue) {
    if (yValue == 0) {
      return Center(
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            Image.asset(
              objects[1],
              width: width * 0.13,
              height: height * 0.12,
            )
          ],
        ),
      );
    }
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < yValue; i++)
            Image.asset(
              objects[0],
              width: width * 0.13,
              height: height * 0.12,
            )
        ],
      ),
    );
  }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                children: <Widget>[NextButton(nextQuestion: nextQuestion)])),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ImagesUnderQuestion(int j) {
    if (j == 0 || j == 1 || j == 2 || j == 3) {
      return SizedBox(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                      height: height * 0.30, child: _printImageX(Xx[j], Yy[j])),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: SizedBox(
                        child: Image.asset(
                          'images/basket.png',
                          height: height * 0.50,
                          width: width * 0.40,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: height * 0.01,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // ),
        //  ),
        //   ),
        // ),
      );
    } else if (j == 4 || j == 5 || j == 6 || j == 7) {
      return SizedBox(
        height: height * 0.55,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/dogFrame.png',
                      height: height * 0.49,
                      width: width * 0.30,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Text(
                              "  ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.14,
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 33.0),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                            height: height * 0.10,
                            child: Text(
                              qustions[j].toString().substring(0, 2),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.01,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(
                                  width: width * 0.09,
                                  height: height * 0.10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          ' × ',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 33.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                            height: height * 0.10,
                            // width: 35,
                            // height: 40,
                            child: Text(
                              qustions[j].toString().substring(6),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.75,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: width * 0.09,
                                  height: height * 0.12,
                                  // width: 63,
                                  // height: 44,
                                  child: Text(
                                    "________",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: height * 0.55,
        // height: 200,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/catFrame.png',
                      height: height * 0.49,
                      width: width * 0.30,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.02,
                            // width: 20,
                            child: Text(
                              "  ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            // width: 30,
                            // height: 50,
                            height: height * 0.14,

                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 33.0),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                            height: height * 0.10,
                            // width: 35,
                            // height: 34,
                            child: Text(
                              qustions[j].toString().substring(0, 2),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.01,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(
                                  width: width * 0.088,
                                  height: height * 0.10,
                                  // width: 67,
                                  // height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        // width: 63,
                                        // height: 44,
                                        child: Text(
                                          ' × ',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 33.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                            height: height * 0.10,
                            // width: 37,
                            // height: 40,
                            child: Text(
                              qustions[j].toString().substring(6),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.75,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: width * 0.09,
                                  height: height * 0.12,
                                  // width: 63,
                                  // height: 44,
                                  child: Text(
                                    "________",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
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
