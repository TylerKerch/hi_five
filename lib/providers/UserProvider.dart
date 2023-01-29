import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:hi_five/models/Emp.dart';

import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  Emp? _emp;
  StreamSubscription? _subscription;
  CachedNetworkImage? _cachedProfilePic;
  Image? _profilePic;

  Emp? get emp => _emp;
  CachedNetworkImage? get pfp => _cachedProfilePic;

  Future<void> setUser(auth.User? currentUser) async {
    if (currentUser != null) {
      _subscription = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        _emp = Emp.fromSnapshot(snapshot);
        notifyListeners();
      });
    } else {
      _subscription?.cancel();
      _emp = null;
    }
  }
}