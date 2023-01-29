import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hi_five/providers/AuthProvider.dart';
import 'package:hi_five/providers/UserProvider.dart';
import 'package:hi_five/screens/root_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(camera: cameras[1]));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.camera});
  CameraDescription camera;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'HiFive',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunitoSans().fontFamily,
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white
        ),
        home: RootScreen(camera: camera),
      ),
    );
  }
}