import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:husbh_app/screens/login_screen.dart';
import 'learn_page.dart';
import 'WaitingScreen.dart';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';
//bool WaitingScreen = false;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage()));
// }

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
  //const ProfilePage({Key? key}) : super(key: key);
  String? email;
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  var id;
  var email;
  var name;
  var age;
  var sex;

  //add
  var addLevel1 = []; //جمع الآحاد
  var currentScoreAddL1 = 0;
  var secondScoreAddL1 = 0;
  var thirdScoreAddL1 = 0;

  var addLevel2 = []; //جمع العشرات
  var currentScoreAddL2 = 0;
  var secondScoreAddL2 = 0;
  var yearSecondAdd = '';
  var timeSecondAdd = '';
  var thirdScoreAddL2 = 0;
  var yearThirdAdd = '';
  var timeThirdAdd = '';

  var addLevel3 = []; //جمع المئات
  var currentScoreAddL3 = 0;
  var secondScoreAddL3 = 0;
  var thirdScoreAddL3 = 0;

  var addTotal = 0; //مجموع آخر محاولة من كل ليفيل

  ////////////////////////////////////

  //sub
  var subLevel1 = []; //طرح الآحاد
  var currentScoreSubL1 = 0;
  var secondScoreSubL1 = 0;
  var thirdScoreSubL1 = 0;

  var subLevel2 = []; //طرح العشرات
  var currentScoreSubL2 = 0;
  var secondScoreSubL2 = 0;
  var thirdScoreSubL2 = 0;

  var subLevel3 = []; //طرح المئات
  var currentScoreSubL3 = 0;
  var secondScoreSubL3 = 0;
  var thirdScoreSubL3 = 0;
  var subTotal = 0; //مجموع آخر محاولة من كل ليفيل

  //multiplication

  var mulLevel1 = []; // ضرب 0,1,2,4
  var currentScoreMulL1 = 0;
  var secondScoreMulL1 = 0;
  var thirdScoreMulL1 = 0;

  var mulLevel2 = []; // ضرب 3,6,5,10
  var currentScoreMulL2 = 0;
  var secondScoreMulL2 = 0;
  var thirdScoreMulL2 = 0;

  var mulLevel3 = []; // ضرب 7,8,9
  var currentScoreMulL3 = 0;
  var secondScoreMulL3 = 0;
  var thirdScoreMulL3 = 0;

  var mulTotal = 0; //مجموع آخر محاولة من كل ليفيل

  //division
  var divLevel1 = []; // قسمة 0,2,5,10
  var currentScoreDivL1 = 0;
  var secondScoreDivL1 = 0;
  var thirdScoreDivL1 = 0;

  var divLevel2 = []; // قسمة 1,3,4,6
  var currentScoreDivL2 = 0;
  var secondScoreDivL2 = 0;
  var thirdScoreDivL2 = 0;

  var divLevel3 = []; // قسمة 7,8,9
  var currentScoreDivL3 = 0;
  var secondScoreDivL3 = 0;
  var thirdScoreDivL3 = 0;
  var divTotal = 0; //مجموع آخر محاولة من كل ليفيل

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
    getCurrentUser();
  }

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

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["email"] != null && doc["email"] == signedInUser.email) {
          email = doc['email'];
          name = doc['name'];
          age = doc['age'];
          if (age == '٢') {
            age = 'سنتان';
          } else {
            age = age + ' سنوات ';
          }
          sex = doc['sex'];

          print(name);
        }
      });
    });
  }

  Future<void> getScoreLearning() async {
    DocumentSnapshot<Map<String, dynamic>> ADD = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('Score')
        .doc('Add')
        .get();
    DocumentSnapshot<Map<String, dynamic>> SUB = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('Score')
        .doc('Sub')
        .get();
    DocumentSnapshot<Map<String, dynamic>> MUL = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('Score')
        .doc('Mul')
        .get();
    DocumentSnapshot<Map<String, dynamic>> DIV = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('Score')
        .doc('Div')
        .get();

    addLevel1 = ADD['addLevel1'];
    addLevel2 = ADD['addLevel2'];
    addLevel3 = ADD['addLevel3'];

    subLevel1 = SUB['subLevel1'];
    subLevel2 = SUB['subLevel2'];
    subLevel3 = SUB['subLevel3'];

    mulLevel1 = MUL['mulLevel1'];
    mulLevel2 = MUL['mulLevel2'];
    mulLevel3 = MUL['mulLevel3'];

    divLevel1 = DIV['divLevel1'];
    divLevel2 = DIV['divLevel2'];
    divLevel3 = DIV['divLevel3'];

    print(addLevel1[0]['time']);
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    getData();
    getScoreLearning();
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: getData(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Scaffold(
                    body: Stack(
                      children: [
                        Container(
                          width: MediaQuery.maybeOf(context)?.size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                          // child: Text("plase wait")
                        ),
                        WaitingScreen(),
                      ],
                    ),
                  )

                // محتوى الصفحة
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: Colors.amber[300],
                      extendBodyBehindAppBar: true,
                      body: SafeArea(
                        child: Stack(
                          children: [
                            //زر الرجوع
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => learn_page()),
                                  // );
                                  Navigator.pop(context);

                                  // add new scores to first level
                                  // addLevel1 = addLevel1 + [45];
                                  // FirebaseFirestore.instance
                                  //     .collection("users")
                                  //     .doc(user.uid)
                                  //     .update({
                                  //   "addAhad": addLevel1,
                                  //    'time':  FieldValue.serverTimestamp(),
                                  // });
                                  // print(user.uid.runtimeType);
                                  // Map<String, dynamic> level1 = {
                                  //   'score': 0,
                                  //   'year': year(),
                                  //   'time': time(),
                                  // };
                                  // Map<String, dynamic> level2 = {
                                  //   'score': 0,
                                  //   'year': year(),
                                  //   'time': time(),
                                  // };
                                  // Map<String, dynamic> level3 = {
                                  //   'score': 4,
                                  //   'year': year(),
                                  //   'time': time(),
                                  // };

                                  // FirebaseFirestore.instance
                                  //     .collection('users')
                                  //     .doc(user.uid)
                                  //     .collection('Score')
                                  //     .doc('Add')
                                  //     .update({
                                  //   'addLevel1':
                                  //       FieldValue.arrayUnion([level1]),
                                  //   'addLevel2':
                                  //       FieldValue.arrayUnion([level2]),
                                  //   'addLevel3':
                                  //       FieldValue.arrayUnion([level3]),
                                  // });
                                },
                                icon: Icon(Icons.arrow_back_ios),
                                color: Color(0xff4A4857),
                              ),
                            ),
                            //زر تسجيل الخروج
                            Align(
                                alignment: Alignment.topLeft,
                                child: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.WARNING,
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 2),
                                        width: 280,
                                        buttonsBorderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                        headerAnimationLoop: false,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title:
                                            'هل تريد تسجيل الخروج من التطبيق؟',
                                        btnCancelText: "إلغاء",
                                        btnOkText: "نعم",
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                          );
                                        },
                                        showCloseIcon: true,
                                      ).show();
                                    },
                                    icon: Icon(Icons.logout_rounded),
                                    color: Color(0xff4A4857),
                                  ),
                                )),

                            //الجزء الابيض اللي فيه المحتوى
                            Container(
                              margin: EdgeInsets.only(top: 110.0),
                              height: height,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                            ),

                            // progress
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 150, right: 20),
                              child: Row(
                                children: [
                                  //الكونتينر الأبيض حق تقاريري
                                  Container(
                                    height: height / 2,
                                    width: width * 0.42,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            'تقاريري',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'ReadexPro',
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // تقاريري
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 20,
                                            ),
                                            child: GridView(
                                                shrinkWrap: true,
                                                children: [
                                                  //الكونتينر البرتقالي حق الجمع
                                                  GestureDetector(
                                                    onTap: () {
                                                      addTotal = 0;
                                                      print("add");

                                                      if (addLevel1
                                                          .isNotEmpty) {
                                                        addTotal += addLevel1[
                                                                addLevel1
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (addLevel2
                                                          .isNotEmpty) {
                                                        addTotal += addLevel2[
                                                                addLevel2
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                        print('5555');
                                                      }
                                                      if (addLevel3
                                                          .isNotEmpty) {
                                                        addTotal += addLevel3[
                                                                addLevel3
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      print(currentScoreAddL1);
                                                      currentScoreAddL1 = 0;
                                                      currentScoreAddL2 = 0;
                                                      currentScoreAddL3 = 0;
                                                      secondScoreAddL1 = 0;
                                                      secondScoreAddL2 = 0;
                                                      secondScoreAddL3 = 0;
                                                      thirdScoreAddL1 = 0;
                                                      thirdScoreAddL2 = 0;
                                                      thirdScoreAddL3 = 0;
                                                      yearSecondAdd =
                                                          'لايوجد بعد';
                                                      timeSecondAdd = '';
                                                      yearThirdAdd =
                                                          'لايوجد بعد';
                                                      timeThirdAdd = '';
                                                      if ((addLevel1.length) >
                                                          0) {
                                                        currentScoreAddL1 =
                                                            addLevel1[addLevel1
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((addLevel2.length) >
                                                          0) {
                                                        currentScoreAddL2 =
                                                            addLevel2[addLevel2
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((addLevel3.length) >
                                                          0) {
                                                        currentScoreAddL3 =
                                                            addLevel3[addLevel3
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((addLevel1.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreAddL1 =
                                                            addLevel1[addLevel1
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondAdd =
                                                            addLevel1[addLevel1
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondAdd =
                                                            addLevel1[addLevel1
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((addLevel2.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreAddL2 =
                                                            addLevel2[addLevel2
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondAdd =
                                                            addLevel2[addLevel2
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondAdd =
                                                            addLevel2[addLevel2
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((addLevel3.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreAddL3 =
                                                            addLevel3[addLevel3
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondAdd =
                                                            addLevel3[addLevel3
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondAdd =
                                                            addLevel3[addLevel3
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((addLevel1.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreAddL1 =
                                                            addLevel1[addLevel1
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdAdd =
                                                            addLevel1[addLevel1
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdAdd =
                                                            addLevel1[addLevel1
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((addLevel2.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreAddL2 =
                                                            addLevel2[addLevel2
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdAdd =
                                                            addLevel2[addLevel2
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdAdd =
                                                            addLevel2[addLevel2
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((addLevel3.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreAddL3 =
                                                            addLevel3[addLevel3
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdAdd =
                                                            addLevel3[addLevel3
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdAdd =
                                                            addLevel3[addLevel3
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      // البوب اب ويندو

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          addTotal,
                                                          '     جمع الآحاد',
                                                          "جمع العشرات",
                                                          "    جمع المئات",
                                                          currentScoreAddL1,
                                                          secondScoreAddL1,
                                                          thirdScoreAddL1,
                                                          currentScoreAddL2,
                                                          secondScoreAddL2,
                                                          thirdScoreAddL2,
                                                          currentScoreAddL3,
                                                          secondScoreAddL3,
                                                          thirdScoreAddL3,
                                                          yearSecondAdd,
                                                          timeSecondAdd,
                                                          yearThirdAdd,
                                                          timeThirdAdd);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[500],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[400]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق الطرح
                                                  GestureDetector(
                                                    onTap: () {
                                                      subTotal = 0;
                                                      print("sub");

                                                      if (subLevel1
                                                          .isNotEmpty) {
                                                        subTotal += subLevel1[
                                                                subLevel1
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (subLevel2
                                                          .isNotEmpty) {
                                                        subTotal += subLevel2[
                                                                subLevel2
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (subLevel3
                                                          .isNotEmpty) {
                                                        subTotal += subLevel3[
                                                                subLevel3
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }

                                                      currentScoreSubL1 = 0;
                                                      currentScoreSubL2 = 0;
                                                      currentScoreSubL3 = 0;
                                                      secondScoreSubL1 = 0;
                                                      secondScoreSubL2 = 0;
                                                      secondScoreSubL3 = 0;
                                                      thirdScoreSubL1 = 0;
                                                      thirdScoreSubL2 = 0;
                                                      thirdScoreSubL3 = 0;

                                                      var yearSecondSub =
                                                          'لايوجد بعد';
                                                      var timeSecondSub = '';
                                                      var yearThirdSub =
                                                          'لايوجد بعد';
                                                      var timeThirdSub = '';
                                                      if ((subLevel1.length) >
                                                          0) {
                                                        currentScoreSubL1 =
                                                            subLevel1[subLevel1
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((subLevel2.length) >
                                                          0) {
                                                        currentScoreSubL2 =
                                                            subLevel2[subLevel2
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((subLevel3.length) >
                                                          0) {
                                                        currentScoreSubL3 =
                                                            subLevel3[subLevel3
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((subLevel1.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreSubL1 =
                                                            subLevel1[subLevel1
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondSub =
                                                            subLevel1[subLevel1
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondSub =
                                                            subLevel1[subLevel1
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((subLevel2.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreSubL2 =
                                                            subLevel2[subLevel2
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondSub =
                                                            subLevel2[subLevel2
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondSub =
                                                            subLevel2[subLevel2
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((subLevel3.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreSubL3 =
                                                            subLevel3[subLevel3
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondSub =
                                                            subLevel3[subLevel3
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondSub =
                                                            subLevel3[subLevel3
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((subLevel1.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreSubL1 =
                                                            subLevel1[subLevel1
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdSub =
                                                            subLevel1[subLevel1
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdSub =
                                                            subLevel1[subLevel1
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((subLevel2.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreSubL2 =
                                                            subLevel2[subLevel2
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdSub =
                                                            subLevel2[subLevel2
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdSub =
                                                            subLevel2[subLevel2
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((subLevel3.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreSubL3 =
                                                            subLevel3[subLevel3
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdSub =
                                                            subLevel3[subLevel3
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdSub =
                                                            subLevel3[subLevel3
                                                                    .length -
                                                                3]['time'];
                                                      }

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          subTotal,
                                                          '     طرح الآحاد',
                                                          "طرح العشرات",
                                                          "   طرح المئات",
                                                          currentScoreSubL1,
                                                          secondScoreSubL1,
                                                          thirdScoreSubL1,
                                                          currentScoreSubL2,
                                                          secondScoreSubL2,
                                                          thirdScoreSubL2,
                                                          currentScoreSubL3,
                                                          secondScoreSubL3,
                                                          thirdScoreSubL3,
                                                          yearSecondSub,
                                                          timeSecondSub,
                                                          yearThirdSub,
                                                          timeThirdSub);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[400],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[300]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق الضرب
                                                  GestureDetector(
                                                    onTap: () {
                                                      mulTotal = 0;
                                                      print("mul");

                                                      if (mulLevel1
                                                          .isNotEmpty) {
                                                        mulTotal += mulLevel1[
                                                                mulLevel1
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (mulLevel2
                                                          .isNotEmpty) {
                                                        mulTotal += mulLevel2[
                                                                mulLevel2
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (mulLevel3
                                                          .isNotEmpty) {
                                                        mulTotal += mulLevel3[
                                                                mulLevel3
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }

                                                      currentScoreMulL1 = 0;
                                                      currentScoreMulL2 = 0;
                                                      currentScoreMulL3 = 0;
                                                      secondScoreMulL1 = 0;
                                                      secondScoreMulL2 = 0;
                                                      secondScoreMulL3 = 0;
                                                      thirdScoreMulL1 = 0;
                                                      thirdScoreMulL2 = 0;
                                                      thirdScoreMulL3 = 0;

                                                      var yearSecondMul =
                                                          'لايوجد بعد';
                                                      var timeSecondMul = '';
                                                      var yearThirdMul =
                                                          'لايوجد بعد';
                                                      var timeThirdMul = '';
                                                      if ((mulLevel1.length) >
                                                          0) {
                                                        currentScoreMulL1 =
                                                            mulLevel1[mulLevel1
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((mulLevel2.length) >
                                                          0) {
                                                        currentScoreMulL2 =
                                                            mulLevel2[mulLevel2
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((mulLevel3.length) >
                                                          0) {
                                                        currentScoreMulL3 =
                                                            mulLevel3[mulLevel3
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((mulLevel1.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreMulL1 =
                                                            mulLevel1[mulLevel1
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondMul =
                                                            mulLevel1[mulLevel1
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondMul =
                                                            mulLevel1[mulLevel1
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((mulLevel2.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreMulL2 =
                                                            mulLevel2[mulLevel2
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondMul =
                                                            mulLevel2[mulLevel2
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondMul =
                                                            mulLevel2[mulLevel2
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((mulLevel3.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreMulL3 =
                                                            mulLevel3[mulLevel3
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondMul =
                                                            mulLevel3[mulLevel3
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondMul =
                                                            mulLevel3[mulLevel3
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((mulLevel1.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreMulL1 =
                                                            mulLevel1[mulLevel1
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdMul =
                                                            mulLevel1[mulLevel1
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdMul =
                                                            mulLevel1[mulLevel1
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((mulLevel2.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreMulL2 =
                                                            mulLevel2[mulLevel2
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdMul =
                                                            mulLevel2[mulLevel2
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdMul =
                                                            mulLevel2[mulLevel2
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((mulLevel3.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreMulL3 =
                                                            mulLevel3[mulLevel3
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdMul =
                                                            mulLevel3[mulLevel3
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdMul =
                                                            mulLevel3[mulLevel3
                                                                    .length -
                                                                3]['time'];
                                                      }

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          mulTotal,
                                                          '  ضرب (۰,۱,۲,۳)',
                                                          "ضرب (٦,٧, ٤,٥)",
                                                          "   ضرب (۹,۱۰, ۸)",
                                                          currentScoreMulL1,
                                                          secondScoreMulL1,
                                                          thirdScoreMulL1,
                                                          currentScoreMulL2,
                                                          secondScoreMulL2,
                                                          thirdScoreMulL2,
                                                          currentScoreMulL3,
                                                          secondScoreMulL3,
                                                          thirdScoreMulL3,
                                                          yearSecondMul,
                                                          timeSecondMul,
                                                          yearThirdMul,
                                                          timeThirdMul);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[300],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[200]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '×',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق القسمة
                                                  GestureDetector(
                                                    onTap: () {
                                                      divTotal = 0;
                                                      print("div");

                                                      if (divLevel1
                                                          .isNotEmpty) {
                                                        divTotal += divLevel1[
                                                                divLevel1
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      if (divLevel2
                                                          .isNotEmpty) {
                                                        divTotal += divLevel2[
                                                                divLevel2
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                        print('5555');
                                                      }
                                                      if (divLevel3
                                                          .isNotEmpty) {
                                                        divTotal += divLevel3[
                                                                divLevel3
                                                                        .length -
                                                                    1]['score']
                                                            as int;
                                                      }
                                                      print(divTotal);

                                                      currentScoreDivL1 = 0;
                                                      currentScoreDivL2 = 0;
                                                      currentScoreDivL3 = 0;
                                                      secondScoreDivL1 = 0;
                                                      secondScoreDivL2 = 0;
                                                      secondScoreDivL3 = 0;
                                                      thirdScoreDivL1 = 0;
                                                      thirdScoreDivL2 = 0;
                                                      thirdScoreDivL3 = 0;

                                                      var yearSecondDiv =
                                                          'لايوجد بعد';
                                                      var timeSecondDiv = '';
                                                      var yearThirdDiv =
                                                          'لايوجد بعد';
                                                      var timeThirdDiv = '';
                                                      if ((divLevel1.length) >
                                                          0) {
                                                        currentScoreDivL1 =
                                                            divLevel1[divLevel1
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((divLevel2.length) >
                                                          0) {
                                                        currentScoreDivL2 =
                                                            divLevel2[divLevel2
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((divLevel3.length) >
                                                          0) {
                                                        currentScoreDivL3 =
                                                            divLevel3[divLevel3
                                                                        .length -
                                                                    1]['score']
                                                                as int;
                                                      }
                                                      if ((divLevel1.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreDivL1 =
                                                            divLevel1[divLevel1
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondDiv =
                                                            divLevel1[divLevel1
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondDiv =
                                                            divLevel1[divLevel1
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((divLevel2.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreDivL2 =
                                                            divLevel2[divLevel2
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondDiv =
                                                            divLevel2[divLevel2
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondDiv =
                                                            divLevel2[divLevel2
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((divLevel3.length -
                                                              2) >=
                                                          0) {
                                                        secondScoreDivL3 =
                                                            divLevel3[divLevel3
                                                                        .length -
                                                                    2]['score']
                                                                as int;
                                                        yearSecondDiv =
                                                            divLevel3[divLevel3
                                                                    .length -
                                                                2]['year'];
                                                        timeSecondDiv =
                                                            divLevel3[divLevel3
                                                                    .length -
                                                                2]['time'];
                                                      }
                                                      if ((divLevel1.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreDivL1 =
                                                            divLevel1[divLevel1
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdDiv =
                                                            divLevel1[divLevel1
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdDiv =
                                                            divLevel1[divLevel1
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((divLevel2.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreDivL2 =
                                                            divLevel2[divLevel2
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdDiv =
                                                            divLevel2[divLevel2
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdDiv =
                                                            divLevel2[divLevel2
                                                                    .length -
                                                                3]['time'];
                                                      }
                                                      if ((divLevel3.length -
                                                              3) >=
                                                          0) {
                                                        thirdScoreDivL3 =
                                                            divLevel3[divLevel3
                                                                        .length -
                                                                    3]['score']
                                                                as int;
                                                        yearThirdDiv =
                                                            divLevel3[divLevel3
                                                                    .length -
                                                                3]['year'];
                                                        timeThirdDiv =
                                                            divLevel3[divLevel3
                                                                    .length -
                                                                3]['time'];
                                                      }

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          divTotal,
                                                          '  قسمة (۰,۱,۲,۳)',
                                                          "قسمة (٦,٧, ٤,٥)",
                                                          "   قسمة (۹,۱۰, ۸)",
                                                          currentScoreDivL1,
                                                          secondScoreDivL1,
                                                          thirdScoreDivL1,
                                                          currentScoreDivL2,
                                                          secondScoreDivL2,
                                                          thirdScoreDivL2,
                                                          currentScoreDivL3,
                                                          secondScoreDivL3,
                                                          thirdScoreDivL3,
                                                          yearSecondDiv,
                                                          timeSecondDiv,
                                                          yearThirdDiv,
                                                          timeThirdDiv);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[200],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[100]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '÷',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      2, // how much coulmn
                                                  crossAxisSpacing:
                                                      10, // vertical space
                                                  mainAxisSpacing: 10,
                                                  mainAxisExtent:
                                                      50, // here set custom Height You Want
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18),

                                  //الكونتينر الابيض حق نقاطي
                                  Container(
                                    height: height * 0.50,
                                    width: width * 0.50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Text(
                                          'نقاطي',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'ReadexPro',
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.035,
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print('add points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.7,
                                                  center: new Text(
                                                    " ٧۰ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: new Text(
                                                      "عملية الجمع",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.purple,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('subtraction points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.5,
                                                  center: new Text(
                                                    " ٥۰ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: new Text(
                                                      "عملية الطرح",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.green,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print(
                                                      'multiplication points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.35,
                                                  center: new Text(
                                                    " ۳٥ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: new Text(
                                                      "عملية الضرب",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('division points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.17,
                                                  center: new Text(
                                                    " ۱٧ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: new Text(
                                                      "عملية القسمة",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor:
                                                      Colors.lightBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //معلومات الطفل اللي تطلع فوق
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 65, top: 10),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: sex == "boy"
                                              ? AssetImage(
                                                  "images/husbh_boy.png")
                                              : AssetImage(
                                                  "images/husbh_girl.png"),
                                          scale: 0.02,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                        boxShadow: [
                                          BoxShadow(
                                            // color: Colors
                                            //     .yellow
                                            //     .shade100,
                                            color: Colors.grey.shade300,
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 17.0),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.ende,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 25,
                                                fontFamily: 'ReadexPro',
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(width: 20, height: 1),
                                          Text(age,
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 10,
                                                  fontFamily: 'ReadexPro',
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(width: 20, height: 5),
                                          Text(email,
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 10,
                                                  fontFamily: 'ReadexPro',
                                                  fontWeight: FontWeight.w700))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          );
        });
  }

  Future<dynamic> popUpWindow(
    BuildContext context,
    double height,
    double width, // هذول دايم نفسهم مايتغيرون
    int total,
    String level1,
    String level2,
    String level3,
    int currentScoreLevel1,
    int secondScoreLevel1,
    int thirdScoreLevel1,
    int currentScoreLevel2,
    int secondScoreLevel2,
    int thirdScoreLevel2,
    int currentScoreLevel3,
    int secondScoreLevel3,
    int thirdScoreLevel3,
    String year2,
    String time2,
    String year3,
    String time3,
  ) {
    // total --> توتال السكور بكل المهارات من 12
    // level1 --> اسم المهارة الأولى
    // level2 --> اسم المهارة الثانية
    // level3 --> اسم المهارة الثالثة
    // currentScoreLevel1 --> ناتج سكور آخر محاولة من أول ليفيل أو أول مهارة
    // currentScoreLevel2 --> ناتج سكور آخر محاولة من ثاني ليفيل أو ثاني مهارة
    // currentScoreLevel2 --> ناتج سكور آخر محاولة من ثالث ليفيل أو ثالث مهارة

    // secondScoreLevel1 --> ناتج سكور ثاني محاولة من أول ليفيل أو أول مهارة
    // secondScoreLevel2 --> ناتج سكور ثاني محاولة من ثاني ليفيل أو ثاني مهارة
    // secondScoreLevel3 --> ناتج سكور ثاني محاولة من ثالث ليفيل أو ثالث مهارة

    // thirdScoreLevel1 --> ناتج سكور ثالث محاولة من أول ليفيل أو أول مهارة
    // thirdScoreLevel2 --> ناتج سكور ثالث محاولة من ثاني ليفيل أو ثاني مهارة
    // thirdScoreLevel3 --> ناتج سكور ثالث محاولة من ثالث ليفيل أو ثالث مهارة
    // year2 --> the year of the score of the second chance
    // time2 --> the time of the score of the second chance

    // year3 --> the year of the score of the second chance
    // time3 --> the time of the score of the second chance

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none, children: <Widget>[
                SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.66,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.15,
                                    ),
                                    currentLevel(total),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                    currentLevelPer(currentScoreLevel1, level1),
                                    currentLevelPer(currentScoreLevel2, level2),
                                    currentLevelPer(currentScoreLevel3, level3),
                                  
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.20,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade200,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(160),
                                  bottomLeft: Radius.circular(160),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'المستوى الحالي',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'ReadexPro',
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.030,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: height * 0.66,
                              width: width * 0.50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.12,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        // left: 20, bottom: 5
                                                        ),
                                                child: Text(
                                                  year2 + '\n' + time2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'ReadexPro',
                                                    color: Colors.brown,
                                                    fontWeight:
                                                        FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              currentLevelPer(
                                                  secondScoreLevel1, level1),
                                              currentLevelPer(
                                                  secondScoreLevel2, level2),
                                              currentLevelPer(
                                                  secondScoreLevel3, level3),
                                            ],
                                          ),
                                          SizedBox(
                                            width: width *0.015,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            color: Colors.black45,
                                            height: height * 0.27,
                                            width: 1,
                                          ),
                                          SizedBox(
                                            width: width *0.015,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        // left: 20, bottom: 5
                                                        ),
                                                child: Text(
                                                  year3 + '\n' + time3,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'ReadexPro',
                                                    color: Colors.brown,
                                                    fontWeight:
                                                        FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              currentLevelPer(
                                                  thirdScoreLevel1, level1),
                                              currentLevelPer(
                                                  thirdScoreLevel2, level2),
                                              currentLevelPer(
                                                  thirdScoreLevel3, level3),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.20,
                              width: width * 0.50,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade200,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(160),
                                  bottomLeft: Radius.circular(160),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'المستوى في المحاولات السابقة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'ReadexPro',
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                      radius: 13,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.65,
                  height: height * 0.85,
                ),
              ],
            ),
          );
        });
  }

  Row currentLevelPer(score, name) {
    double per = ((score / 4));

    return Row(children: [
      if (score == 0) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: new LinearPercentIndicator(
            width: 98,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.w900,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٠.٠٠",
              style: new TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.red,
          ),
        ))
      ] else if (score == 1) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: new LinearPercentIndicator(
            width: 98,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.w900,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%۲٥",
              style: new TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.w900,
              ),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.yellow,
          ),
        ))
      ] else if (score == 2) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: new LinearPercentIndicator(
            width: 98,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.w900,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٥۰",
              style: new TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.blue,
          ),
        ))
      ] else if (score == 3) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: new LinearPercentIndicator(
            width: 98,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.w900,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٧٥",
              style: new TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.orange,
          ),
        ))
      ] else if (score == 4) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: new LinearPercentIndicator(
            width: 98,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.w900,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%۱۰۰",
              style: new TextStyle(
                fontSize: 10,
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.lightGreen,
          ),
        ))
      ]
    ]);
  }

  Row currentLevel(score) {
    String img;
    var level;
    Text txt = Text("images/golden.png");
    return Row(
      children: [
        if (score >= 9) ...[
          //اذا الطفل جاب 9 أو فوق من أصل 12 بوينتز
          Container(
            width: 60,
            child: Image.asset("images/golden.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "متقدم",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else if (score >= 6) ...[
          //اذا الطفل جاب 6 أو فوق من أصل 12 بوينتز
          Container(
            width: 60,
            child: Image.asset("images/silver.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "متوسط",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          //اذا الطفل جاب أقل من 5 من أصل 12 بوينتز
          Container(
            width: 60,
            child: Image.asset("images/bronze.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "مبتدئ",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
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
