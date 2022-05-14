import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:husbh_app/screens/learn_page.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../profile.dart';

class divisionResultScreen extends StatelessWidget {
  final divlevel1Score;
  final divlevel2Score;
  final divlevel3Score;
  final maxLevel1ScoreDiv;
  final maxLevel2ScoreDiv;
  final maxLevel3ScoreDiv;
  final List qustions;
  final List answers;
  final List userAnswer;
  late final totalDivScore;
  late final maxTotalDivScore;
  ArabicNumbers arabicNumber = ArabicNumbers();
  late final divlevel1scoreArabic;
  late final maxLevel1ScoreArabic;
  late final divlevel2scoreArabic;
  late final maxLevel2scoreArabic;
  late final divlevel3scoreArabic;
  late final maxLevel3scoreArabic;
  //total score & in arabic
  late final totalDivScoreArabic;
  late final maxTotalDivScoreArabic;

  divisionResultScreen({
    this.divlevel1Score,
    this.divlevel2Score,
    this.divlevel3Score,
    this.maxLevel1ScoreDiv,
    this.maxLevel2ScoreDiv,
    // this.singlescoreArabic,
    this.maxLevel3ScoreDiv,
    required this.qustions,
    required this.answers,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    //calculate the total score
    totalDivScore = divlevel1Score + divlevel2Score + divlevel3Score;
    maxTotalDivScore =
        maxLevel1ScoreDiv + maxLevel2ScoreDiv + maxLevel3ScoreDiv;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    divlevel1scoreArabic = arabicNumber.convert(divlevel1Score);
    maxLevel1ScoreArabic = arabicNumber.convert(maxLevel1ScoreDiv);
    divlevel2scoreArabic = arabicNumber.convert(divlevel2Score);
    maxLevel2scoreArabic = arabicNumber.convert(maxLevel2ScoreDiv);
    divlevel3scoreArabic = arabicNumber.convert(divlevel3Score);
    maxLevel3scoreArabic = arabicNumber.convert(maxLevel3ScoreDiv);

    //convert total score to arabic
    totalDivScoreArabic = arabicNumber.convert(totalDivScore);
    maxTotalDivScoreArabic = arabicNumber.convert(maxTotalDivScore);

    TextDirection.rtl;
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/farm.jpg'),
            fit: BoxFit.cover,
          ),
        )),
        Stack(
          children: [
            Center(
              child: Container(
                height: height * 0.75,
                width: width * 0.35,
                //color: Colors.white,
                //blur: 0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 247, 247),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 163, 163, 163).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(2, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.lime,
                    width: 1,
                  ),
                ),
                child: Column(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      'النتيجة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 29.0,
                          color: Colors.brown,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    //The results المجموع:
                    Text(
                      'المجموع : $totalDivScoreArabic من $maxTotalDivScoreArabic',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 23.0,
                          color: Colors.brown,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 25),
                    NiceButtons(
                        stretch: false,
                        startColor: Color.fromARGB(255, 57, 207, 40),
                        endColor: Color.fromARGB(255, 57, 207, 40),
                        borderColor: Color.fromARGB(255, 47, 119, 48),
                        // startColor: Colors.lightBlueAccent,
                        // endColor: Colors.lightBlueAccent,
                        // borderColor: Color(0xFF3489e9),
                        width: width * 0.24,
                        height: height * 0.11,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        //Navigate to learn page
                        onTap: (finish) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                        child: Text('التقرير',
                            //'ارني مستواي'
                            //'العودة'
                            //'رؤية النتيجة في الصفحة الشخصية'
                            //'العودة إلى الصفحة الرئيسية'
                            //'لعودة الى صفحة التعلم'
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: 10),
                    NiceButtons(
                        stretch: false,
                        startColor: Color.fromARGB(255, 211, 66, 66),
                        endColor: Color.fromARGB(255, 211, 66, 66),
                        borderColor: Color.fromARGB(255, 123, 25, 25),
                        width: width * 0.24,
                        height: height * 0.11,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        //Navigate to learn page
                        onTap: (finish) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => learn_page()),
                          );
                        },
                        child: Text('انهاء',
                            //'حسنا'
                            //'العودة'
                            //'رؤية النتيجة في الصفحة الشخصية'
                            //'العودة إلى الصفحة الرئيسية'
                            //'لعودة الى صفحة التعلم'
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 244, 247, 247),
                    //color: Colors.black,
                  ),
                  // blur: 1,
                  height: height * 0.27,
                  width: width * 0.12,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/rabbit_result.png',
                      height: height * 0.23,
                      width: width * 0.23,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
