//import needed libraries
import 'dart:async';
import 'package:husbh_app/screens/multiplication/multiplication_video.dart';
import 'multiplicationQuizScreen.dart';
import 'package:husbh_app/screens/profile.dart';
import 'package:video_player/video_player.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //set the device orientation to landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(multiplicationVideo());
}

// ignore: camel_case_types
class multiplicationVideo extends StatefulWidget {
  const multiplicationVideo({Key? key}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<multiplicationVideo> {
  late VideoPlayerController _controller; //the controller of the video player

  late Timer timer; //timer for the video duration
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/multiplication.mp4')
      ..initialize().then((_) {
        _controller.setVolume(1.0); //video sound (volume)
        _controller.setLooping(false); //do not repeat the video when finish
        _controller.play(); //play the video

        //nevigate to the question page when the video is finish
        timer = Timer(
            Duration(minutes: 1, seconds: 04),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const multiplicationQuizScreen(),
                )));

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    //fit to the screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: width,
                height: height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(30.0),
            child: NiceButtons(
                //A skip button to go to the questions page
                stretch: false,
                startColor: Colors.lightBlueAccent,
                endColor: Colors.lightBlueAccent,
                borderColor: Color(0xFF3489e9),
                width: 100.0,
                height: 60,
                borderRadius: 60,
                gradientOrientation: GradientOrientation.Horizontal,
                onTap: (finish) {
                  //Navigate to the questions page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const multiplicationQuizScreen()),
                  );
                  _controller
                      .pause(); //stop the video when naviagte to the questions page
                  timer.cancel(); //canel the timer if the skip button is used
                },
                child: Text('تخطي',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer.cancel(); //cancel the timer
  }
}
