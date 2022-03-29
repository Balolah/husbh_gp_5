import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 243, 236, 228),
      child: Center(
        child: SpinKitFoldingCube(
          color: Color.fromARGB(255, 252, 187, 113),
          size: 100.0,
        ),
      ),
    );
    // TODO: implement build
    // throw UnimplementedError();
  }//SpinKitFoldingCube(
//           color: Color.fromARGB(255, 252, 187, 113),
//           size: 100.0,
 }