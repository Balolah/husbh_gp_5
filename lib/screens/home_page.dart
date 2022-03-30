// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

//import whats needed for the database (FireBase)
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:husbh_app/screens/profile.dart';

//import whats needed for styling & properties
import 'package:nice_buttons/nice_buttons.dart';

//import project's files
import 'WaitingScreen.dart';
import 'learn_page.dart';

class home_page extends StatefulWidget {
  @override
  State<home_page> createState() => _homepageState();
}

@override
class _homepageState extends State<home_page> {
  //user's info
  late User user;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  var sex;
  var age;
  var name;

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
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getData() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('users').get(); //no null
    querySnapshot.docs.forEach((doc) {
      if (doc["email"] == signedInUser.email) {
        name = doc['name'];
        age = doc['age'];
        sex = doc['sex'];
        print(doc['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Scaffold(
                    body: Stack(
                    textDirection: TextDirection.rtl,

                    //Waiting screen
                    // WaitingScreen()
                  ))
                : Stack(//Stack for all components

                    children: [
                    //background
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home_background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

//profile image
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 20.0),
                      child: Row(textDirection: TextDirection.rtl, children: [
                        GestureDetector(
                          //navigate to profile page
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },

                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                image: sex ==
                                        "boy" //if the user (child) is boy, show husbh boy, otherwise husbh girl
                                    ? AssetImage('images/husbh_boy.png')
                                    : AssetImage('images/husbh_girl.png'),
                              ),
                              //style
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                //color: Color(0xFF3489e9),
                                color: Colors.amber,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        //fetch user name & text as button to navigate to profile page
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            },
                            child: Text(
                              '$name'.toString(), //in arabic
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'ReadexPro-Regular',
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0,
                                color: Color.fromARGB(255, 255, 191, 0),
                              ),
                            ))
                      ]),
                    ),

                    //logo
                    Column(
                        //center logo
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //logo
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Image.asset(
                              'images/husbhlogo_homepage.png',
                              //image size
                              height: 180,
                              width: 180,
                            ),
                          ),

                          //Row that has 2 main button: learn & game
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                //Learn button
                                NiceButtons(
                                    stretch: false,
                                    startColor: Colors.lightBlueAccent,
                                    endColor: Colors.lightBlueAccent,
                                    borderColor: Color(0xFF3489e9),
                                    width: 170.0,
                                    height: 100.0,
                                    borderRadius: 60.0,
                                    gradientOrientation:
                                        GradientOrientation.Horizontal,
                                    //Navigate to learn page
                                    onTap: (finish) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => learn_page()),
                                      );
                                    },
                                    child: Text('!تعلم',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 32.0,
                                            color: Colors.white,
                                            fontFamily: 'ReadexPro-Regular',
                                            fontWeight: FontWeight.bold))),

                                SizedBox(width: 10), //Space between buttons

                                //Game button
                                NiceButtons(
                                    stretch: false,
                                    startColor: Colors.lightBlueAccent,
                                    endColor: Colors.lightBlueAccent,
                                    borderColor: Color(0xFF3489e9),
                                    width: 170.0,
                                    height: 100.0,
                                    borderRadius: 60.0,
                                    gradientOrientation:
                                        GradientOrientation.Horizontal,
                                    //Navigate to game page
                                    onTap: (finish) {
                                      /*   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                     builder: (context) => game_page()),
                                   ); */
                                    },
                                    child: Text('!العب',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 32.0,
                                            color: Colors.white,
                                            fontFamily: 'ReadexPro-Regular',
                                            fontWeight: FontWeight.bold))),
                              ]),
                        ])
                  ]));
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
