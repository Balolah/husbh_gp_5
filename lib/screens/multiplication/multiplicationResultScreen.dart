import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:husbh_app/screens/learn_page.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:just_audio/just_audio.dart';
import '../profile.dart';

class multiplicationResultScreen extends StatelessWidget {
  final mullevel1score;
  final mullevel2score;
  final mullevel3score;
  final maxLevel1ScoreMul;
  final maxLevel2ScoreMul;
  final maxLevel3ScoreMul;
  final List qustions;
  final List answers;
  final List userAnswer;
  //total score
  late final totalMulScore;
  late final maxTotalMulScore;
  ArabicNumbers arabicNumber = ArabicNumbers();
  late final mullevel1scoreArabic;
  late final maxLevel1ScoreArabic;
  late final mullevel2sscoreArabic;
  late final maxLevel2ScoreArabic;
  late final mullevel3scoreArabic;
  late final maxLevel3ScoreArabic;
  //total score in arabic
  late final totalMulScoreArabic;
  late final maxTotalMulScoreArabic;

//play audio
  late AudioPlayer player;

  multiplicationResultScreen({
    this.mullevel1score,
    this.mullevel2score,
    this.mullevel3score,
    this.maxLevel1ScoreMul,
    this.maxLevel2ScoreMul,
    this.maxLevel3ScoreMul,
    required this.qustions,
    required this.answers,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    //calculate the total score
    totalMulScore = mullevel1score + mullevel2score + mullevel3score;
    maxTotalMulScore =
        maxLevel1ScoreMul + maxLevel2ScoreMul + maxLevel3ScoreMul;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    mullevel1scoreArabic = arabicNumber.convert(mullevel1score);
    maxLevel1ScoreArabic = arabicNumber.convert(maxLevel1ScoreMul);
    mullevel2sscoreArabic = arabicNumber.convert(mullevel2score);
    maxLevel2ScoreArabic = arabicNumber.convert(maxLevel2ScoreMul);
    mullevel3scoreArabic = arabicNumber.convert(mullevel3score);
    maxLevel3ScoreArabic = arabicNumber.convert(maxLevel3ScoreMul);
    //convert total score to arabic
    totalMulScoreArabic = arabicNumber.convert(totalMulScore);
    maxTotalMulScoreArabic = arabicNumber.convert(maxTotalMulScore);
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
                      'المجموع : $totalMulScoreArabic من $maxTotalMulScoreArabic',
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
