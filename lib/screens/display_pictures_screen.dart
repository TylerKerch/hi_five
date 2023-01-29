import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';
import '../services/image_upload.dart';

class DisplayPicturesScreen extends StatefulWidget {
  const DisplayPicturesScreen({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;

  @override
  DisplayPicturesScreenState createState() => DisplayPicturesScreenState();
}

class DisplayPicturesScreenState extends State<DisplayPicturesScreen> {
  int numFaces = -1;

  @override
  void initState() {
    getFaces();
  }

  void getFaces() async {
    final img.Image capturedImage =
        img.decodeImage(await File(widget.imagePath).readAsBytes())!;
    final img.Image orientedImage = img.bakeOrientation(capturedImage);
    await File(widget.imagePath).writeAsBytes(img.encodeJpg(orientedImage));
    final InputImage inputImage = InputImage.fromFilePath(widget.imagePath);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    setState(() {
      numFaces = faces.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leadingWidth: 250,
            toolbarHeight: 100,
              centerTitle: true,
              title: const Text('hiFive!',
                  style: TextStyle(color: Colors.black, fontSize: 50)),
              backgroundColor: Colors.white,
              leading: Padding(padding: EdgeInsets.only(left:10),
              child: Image.asset("images/logo.png",)),
              elevation: 0),
        ),

        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.all(10),
                surfaceTintColor: Colors.white70,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderOnForeground: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                elevation: 1,
                child: Image.file(File(widget.imagePath))),
      Text(numFaces>=2?"Y'all look great!":(numFaces == 1)?"Where's your buddy?":(numFaces == 0)?"I don't see anyone!":"Loading...", style: TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () async {
                if(numFaces >= 2){
                    File file = File(widget.imagePath);
                    final firebaseStorage = FirebaseStorage.instance;
                    String path = widget.imagePath.substring(widget.imagePath.lastIndexOf("/")+1);
                    var snapshot = await firebaseStorage.ref()
                        .child('images/${path}')
                        .putFile(file);
                    var downloadUrl = await snapshot.ref.getDownloadURL();
                    print(path);
                    print(downloadUrl);
                    ImageUpload.createPost(authProvider.emp, downloadUrl, authProvider.emp2);
                }
                if(mounted){
                    Navigator.of(context).pop();
                }
              },
                child: Text((numFaces>=2)?"See what's happening at the office":"Retake photo", style: TextStyle(fontSize: 15)),
            )
          ],
        ));
  }

}
