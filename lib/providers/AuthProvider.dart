import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/Emp.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  AuthProvider() {
    listenToAuth();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        _loggedIn = false;
        notifyListeners();
      } else {
        _loggedIn = true;
        notifyListeners();
      }
    });
  }
}