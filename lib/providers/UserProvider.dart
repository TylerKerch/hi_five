import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:hi_five/models/Emp.dart';

class UserProvider extends ChangeNotifier {
  Emp? _user;
  StreamSubscription? _subscription;
  CachedNetworkImage? _cachedProfilePic;
  Image? _profilePic;

  Emp? get user => _user;
  CachedNetworkImage? get pfp => _cachedProfilePic;

  Future<void> setUser(auth.User? currentUser) async {
    if (currentUser != null) {
      _subscription = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        _user = Emp.fromSnapshot(snapshot);
        notifyListeners();
      });
    } else {
      _subscription?.cancel();
      _user = null;
    }
  }
}