import 'dart:io';

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  

 @override
 void initState() {
  super.initState();
  _controller = VideoPlayerController.asset(
      'assets/Rabbit.mp4')
    ..initialize().then((value) => {setState(() {})});
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
 }

@override
Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
return Scaffold(
    body: Stack(
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
    //FURTHER IMPLEMENTATION
  ],
)
  
);
}

@override
void dispose() {
 super.dispose();
 _controller.dispose();
}
}

