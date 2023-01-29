import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hi_five/screens/take_picture_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;

import 'display_pictures_screen.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key, required this.camera}) : super(key: key);
  CameraDescription camera;

  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool feed = false;
  @override
  void initState() {
    super.initState();
  }


  void showFeed() {
    if(mounted){
      setState(() {
        feed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(feed){
      return Scaffold(
          body: Container()
      );
    }else{
      return TakePictureScreen(camera: widget.camera, callback: () => showFeed());
    }
  }
}