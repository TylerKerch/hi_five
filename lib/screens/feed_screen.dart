import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hi_five/screens/take_picture_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:flutter_emoji/flutter_emoji.dart';

import '../services/auth_service.dart';
import '../services/image_upload.dart';
import 'display_pictures_screen.dart';

var parser = EmojiParser();
var coffee = Emoji('coffee', '☕');
var hundred  = Emoji('hundred', '💯');
var smile = Emoji('smile', '😄');
var thumbsup = Emoji('thumbsup', '👍');

List<String> emojis = ['coffee', 'hundred', 'smile', 'thumbsup'];

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key, required this.camera}) : super(key: key);
  CameraDescription camera;

  @override
  FeedScreenState createState() => FeedScreenState();
}


class LikeWidget extends StatefulWidget {
  const LikeWidget({Key? key}) : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isPressed = !isPressed;
          });
        },
        color: isPressed ? const Color(0xFFFDDA0D) : Colors.black,
        icon: const Icon(Icons.thumb_up_sharp));
  }
}


class FeedScreenState extends State<FeedScreen> {

  late List<DocumentSnapshot> posts;
  bool feed = false;

  @override
  void initState() {
    super.initState();
    getPosts();
    print("YOO");
  }

  void getPosts() async {
    posts = await ImageUpload.getAllPosts();
    feed = await AuthService.postedToday(auth.FirebaseAuth.instance.currentUser!.uid);
    if(mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    if (feed) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
                leadingWidth: 250,
                toolbarHeight: 100,
                centerTitle: true,
                title: const Text('hiFive!',
                    style: TextStyle(color: Colors.black, fontSize: 35)),
                backgroundColor: Colors.white,
                leading: Padding(padding: EdgeInsets.only(left: 10),
                    child: Image.asset("assets/images/hifive_logo.png",)),
                elevation: 0),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 30,
                margin: const EdgeInsets.all(15),
                shadowColor: const Color(0xFF7fb1ff),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // PROFILE PICTURE INSIDE CONTAINER
                        Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: CircleAvatar(child: Icon(Icons
                              .account_circle_sharp)),),
                        // USERNAME TO BE INSERTED
                        Text("${parser.getName(emojis[Random().nextInt(4)]).code} ${posts.elementAt(index).get(
                            'firstName')} & ${posts.elementAt(index).get(
                            'secondName')}"),
                        Expanded(child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: LikeWidget()))
                      ],
                    ),
                    // DISPLAY IMAGE FROM ARRAY
                    Image.network(posts.elementAt(index).get('image'))
                  ],
                ),
              );
            },
          )
      );
    } else {
      return TakePictureScreen(
          camera: widget.camera, callback: () => getPosts());
    }
  }
}