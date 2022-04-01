import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:husbh_app/screens/login_screen.dart';
import 'package:husbh_app/widgets/my_button.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../widgets/back_arrow.dart';
import 'WaitingScreen.dart';

//bool WaitingScreen = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage()));
}

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
          sex = doc['sex'];
          print(name);
        }
      });
    });
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
    getData();
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

                  //  MaterialApp(
                  //   debugShowCheckedModeBanner: false,//تشيل الخط الاحمر
                  //   home:
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Scaffold(
                          backgroundColor: Colors.amber,
                          extendBodyBehindAppBar: true,
                          appBar: AppBar(
                            centerTitle: true,
                            title: Padding(
                              padding: EdgeInsets.only(left: 330),
                              // child: Text(
                              //   'الملف الشخصي',
                              //   style: TextStyle(
                              //       color:
                              //           Colors.black26,
                              //       fontSize: 25,
                              //       fontFamily: 'ReadexPro',
                              //       fontWeight: FontWeight.w700),
                              // ),
                            ),
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              color: Color(0xff4A4857),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.amber[300],
                          ), //c
                          body: Stack(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                height: double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(width: 20, height: 20),
                                    Expanded(
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width / 2,
                                        child: Column(
                                          children: [
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                //SizedBox(width: 50, height: 50),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 45),
                                                  width: 130,
                                                  height: 130,
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
                                                        // color:
                                                        //     Color.fromARGB(
                                                        //         255,
                                                        //         248,
                                                        //         240,
                                                        //         170),
                                                        color: Colors
                                                            .amber.shade200,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          // color: Colors
                                                          //     .yellow
                                                          //     .shade100,
                                                          color: Colors
                                                              .amber.shade300,
                                                        )
                                                      ]),
                                                ),
                                                Container(
                                                  //color: Colors.black,
                                                  margin:
                                                      EdgeInsets.only(top: 30),
                                                  // padding: EdgeInsets.only(left: 130),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //SizedBox(width: 30, height: 30),
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                              width: 20,
                                                              height: 20),
                                                          Container(
                                                            height: 30,
                                                            width: 250,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    7),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      // color: Color.fromARGB(
                                                                      //     255, 214, 212, 214),
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                  )
                                                                ]),
                                                            child: Row(
                                                              //mainAxisAlignment:
                                                              // MainAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                    width: 20,
                                                                    height: 20),
                                                                Text(
                                                                  "  الاسم : ",
                                                                  style: TextStyle(
                                                                      fontFamily: 'ReadexPro',
                                                                      // background:
                                                                      color: Colors.brown,
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.w800),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  name,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .brown,
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          'ReadexPro',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 250,
                                                        height: 30,
                                                        margin:
                                                            EdgeInsets.all(7),
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                              )
                                                            ]),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 20,
                                                                height: 20),
                                                            Text(
                                                              " العمر: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .brown,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'ReadexPro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(age,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .brown,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'ReadexPro',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700))
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 250,
                                                        height: 30,
                                                        margin:
                                                            EdgeInsets.all(7),
                                                        decoration:
                                                            BoxDecoration(
                                                                //shape: BoxShape.rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                              )
                                                            ]),
                                                        child: Row(
                                                          //mainAxisAlignment:
                                                          //  MainAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                                width: 20,
                                                                height: 20),
                                                            Text(
                                                              " الايميل : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .brown,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'ReadexPro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(email,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .brown,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'ReadexPro',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 10, height: 10),
                                            MyButton(
                                                startColor: Colors.amber,
                                                endColor: Colors.amber.shade400,
                                                borderColor: Color.fromARGB(
                                                    255, 231, 162, 0),
                                                textColor:
                                                    Colors.brown.shade600,
                                                title: 'تسجيل خروج',
                                                onPressed: () {
                                                  AwesomeDialog(
                                                    //if there is missing info this will be displayed
                                                    context: context,
                                                    dialogType:
                                                        DialogType.WARNING,
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                    width: 280,

                                                    buttonsBorderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(2)),
                                                    headerAnimationLoop: false,
                                                    animType:
                                                        AnimType.BOTTOMSLIDE,
                                                    title: 'تسجيل خروج',
                                                    btnCancelText: "إلغاء",
                                                    btnOkText: "نعم",
                                                    desc: 'هل أنت متأكد؟',
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
                                                }),
                                          ],
                                        ),
                                        //الي فيه الصوه

                                        //color: Colors.red,
                                        margin: EdgeInsets.only(top: 50),
                                        height: 300,
                                      ),
                                    ),
                                    Expanded(
                                      //  الي على اليمين الجهه الرصاصي
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          bottom: 60,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey[100],
                                          ),

                                          width: 300,
                                          height: 300,

                                          // alignment: Alignment.center,

                                          child: SingleChildScrollView(
                                            child: Center(
                                              child: Row(children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 40,
                                                      // right: 25,
                                                      // left: 40,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 10,
                                                          ),
                                                          child: Text(
                                                            'أدائي',
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .brown),
                                                          ),
                                                        ),
                                                        Padding(
                                                          //اخر مربعين
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 5,
                                                            // bottom: 5,
                                                          ),

                                                          child:
                                                              SingleChildScrollView(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Card(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(20),
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffE8F2F7),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(2),
                                                                            child:
                                                                                DecoratedBox(
                                                                              decoration: BoxDecoration(
                                                                                //color: Color(0xff7AC1E7),
                                                                                color: Colors.brown,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(7),
                                                                                child: Icon(
                                                                                  Icons.add,
                                                                                  color: Colors.white,
                                                                                  size: 15,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //     width: 3, height: 3),
                                                                Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            // color: Color(0xffEBECF1),
                                                                            ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Card(
                                                                        elevation:
                                                                            10,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(20),
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xffE8F2F7),
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(2),
                                                                              child: DecoratedBox(
                                                                                decoration: BoxDecoration(
                                                                                  //color: Color(0xff7AC1E7),
                                                                                  color: Colors.brown,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(7),
                                                                                  child: Icon(
                                                                                    Icons.remove,
                                                                                    color: Colors.white,
                                                                                    size: 15,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 17,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            80,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration: BoxDecoration(
                                                                              // color: Color(0xffEBECF1),
                                                                              ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Card(
                                                                              elevation: 10,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(20),
                                                                                child: DecoratedBox(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xffE8F2F7),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(2),
                                                                                    child: DecoratedBox(
                                                                                      decoration: BoxDecoration(
                                                                                        //color: Color(0xff7AC1E7),
                                                                                        color: Colors.brown,
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(7),
                                                                                        child: Icon(
                                                                                          Icons.close_rounded,
                                                                                          color: Colors.white,
                                                                                          size: 15,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // SizedBox(
                                                                      //     width: 3, height: 3),
                                                                      Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            80,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration: BoxDecoration(
                                                                              // color: Color(0xffEBECF1),
                                                                              ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Card(
                                                                              elevation: 10,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(20),
                                                                                child: DecoratedBox(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xffE8F2F7),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(2),
                                                                                    child: DecoratedBox(
                                                                                      decoration: BoxDecoration(
                                                                                        //color: Color(0xff7AC1E7),
                                                                                        color: Colors.brown,
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(7),
                                                                                        child: Image.asset(
                                                                                          ('images/divide.png'),
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // حق الباتون الي تحت
                                              ]),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: 100, left: 20),
                                          //width: MediaQuery.of(context).size.width / 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ));
        });
  }
}
