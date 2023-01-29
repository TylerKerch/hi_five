import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;


import '../providers/AuthProvider.dart';
import 'display_pictures_screen.dart';
import 'globals.dart' as globals;

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required this.camera, required this.callback}) : super(key: key);
  final CameraDescription camera;
  final VoidCallback callback;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  String emp2 = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool scanned = false;
  qr.Barcode? result;

  @override
  void initState() {
    super.initState();

    // Obtain a list of the available cameras on the device.

    // Get a specific camera from the list of available cameras.

    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void reassemble() {
    super.reassemble();
    if(globals.qrController == null) {
      return;
    }
    if (Platform.isAndroid) {
      globals.qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      globals.qrController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    emp2 = Provider.of<AuthProvider>(context, listen: false).emp2;
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;
    if (result != null &&
        result!.code == "https://www.youtube.com/watch?v=dQw4w9WgXcQ"){
      Future.delayed(const Duration(milliseconds: 500), (){
        if(globals.qrController != null){
          globals.qrController!.stopCamera();
        }
        if(mounted){
          setState(() {scanned=true;});
        }
      });
    }


    Widget qrScan = Stack(
      children: [
        qr.QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: qr.QrScannerOverlayShape(
                borderColor: Colors.lightBlue,
                borderRadius: 10,
                borderLength: 40,
                borderWidth: 40,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p)),
        if (result != null)
          Center(child: (result!.code == "https://www.youtube.com/watch?v=dQw4w9WgXcQ")?Icon(Icons.check_circle, color: Colors.lightBlue, size: 100):Icon(Icons.cancel, color: Colors.red, size: 100))
      ],
    );
    Widget takePicture = Stack(alignment: Alignment.bottomCenter, children: [
      FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              _controller.lockCaptureOrientation();
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          }),
      // ),
      Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.white, // <-- Button color
            foregroundColor: Colors.black, // <-- Splash color
          ),
          clipBehavior: Clip.none,
          child: Icon(Icons.camera_alt_outlined, size: 30),
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();

              if (!mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPicturesScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                  ),
                ),
              ).then((details) => widget.callback());
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
        ),
      )
    ]);
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
            leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset(
                  "assets/images/hifive_logo.png",
                )),
            elevation: 0),
      ),
      body: Column(children: [
        Expanded(
          child: Card(
              margin: EdgeInsets.all(10),
              surfaceTintColor: Colors.white70,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderOnForeground: false,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              elevation: 1,
              child: (!scanned ? qrScan : takePicture)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Text("Up high or down low? Go give ${emp2} a high five!",
                  style: const TextStyle(fontSize: 20), textAlign: TextAlign.center)),
        ),
      ]),
    );
  }

  void _onQRViewCreated(qr.QRViewController controller) {
    setState(() {
      globals.qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(
      BuildContext context, qr.QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
