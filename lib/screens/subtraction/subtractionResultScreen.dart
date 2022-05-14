import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:husbh_app/screens/learn_page.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../profile.dart';
// import 'package:fabexdateformatter/fabexdateformatter.dart';

class subtractionResultScreen extends StatelessWidget {
  final subsinglescore;
  final subtensscore;
  final subhundredscore;
  final maxSingleScore;
  final maxTensScore;
  final maxHundredScore;
  final List qustions;
  final List answers;
  final List userAnswer;
  //total score
  late final totalSubScore;
  late final maxTotalSubScore;
  ArabicNumbers arabicNumber = ArabicNumbers();
  late final subsinglescoreArabic;
  late final maxSingleScoreArabic;
  late final subtensscoreArabic;
  late final maxtensscoreArabic;
  late final subhundredscoreArabic;
  late final maxhundredscoreArabic;
  //total score in arabic
  late final totalSubScoreArabic;
  late final maxTotalSubScoreArabic;

  subtractionResultScreen({
    this.subsinglescore,
    this.subtensscore,
    this.subhundredscore,
    this.maxSingleScore,
    this.maxTensScore,
    this.maxHundredScore,
    required this.qustions,
    required this.answers,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    //calculate total score
    totalSubScore = subsinglescore + subtensscore + subhundredscore;
    maxTotalSubScore = maxSingleScore + maxTensScore + maxHundredScore;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    subsinglescoreArabic = arabicNumber.convert(subsinglescore);
    maxSingleScoreArabic = arabicNumber.convert(maxSingleScore);
    subtensscoreArabic = arabicNumber.convert(subtensscore);
    maxtensscoreArabic = arabicNumber.convert(maxTensScore);
    subhundredscoreArabic = arabicNumber.convert(subhundredscore);
    maxhundredscoreArabic = arabicNumber.convert(maxHundredScore);
    //convert total score to arabic
    totalSubScoreArabic = arabicNumber.convert(totalSubScore);
    maxTotalSubScoreArabic = arabicNumber.convert(maxTotalSubScore);

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
                      'المجموع : $totalSubScoreArabic من $maxTotalSubScoreArabic',
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
