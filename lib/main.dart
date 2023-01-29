import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hi_five/providers/AuthProvider.dart';
import 'package:hi_five/screens/root_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'HiFive',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RootScreen(),
      ),
    );
  }
}