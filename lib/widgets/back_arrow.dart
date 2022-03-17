import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BackArrow extends StatefulWidget {
  const BackArrow({ Key? key }) : super(key: key);

  @override
  State<BackArrow> createState() => _BackArrowState();
}

class _BackArrowState extends State<BackArrow> {
  @override
  Widget build(BuildContext context) {
    return 
       Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox.fromSize(
  size: Size(30, 30), // button width and height
  child: ClipOval(
    child: Material(
      color: Colors.brown, // button color
      child: InkWell(
        splashColor: Colors.amber, // splash color
        onTap: () {
          // final player = AudioCache();
          //                                player.play('assets/clickButton.mp3');
         Navigator.pop(context);
        }, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(
              
                Icons.arrow_back,
                color: Colors.brown.shade200,
                ),
            ), // icon
             // text
          ],
        ),
      ),
    ),
  ),
),
                     
    );
  }
}