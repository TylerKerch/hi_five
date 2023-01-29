import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/Emp.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  Emp _emp = Emp("","");

  Emp get emp => _emp;
  late String _emp2;
  String get emp2 => _emp2;

  AuthProvider() {
    listenToAuth();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        _loggedIn = false;
        notifyListeners();
      } else {
        String name;
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid).get();
        _emp = Emp("Sean Acaballa", user.email!);
        List<String> users = await AuthService.getAllOtherNames(_emp.email!);
        _emp2 = users[Random().nextInt(users.length)];
        _loggedIn = true;
        notifyListeners();
      }
    });
  }
}