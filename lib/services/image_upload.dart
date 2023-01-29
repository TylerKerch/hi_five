import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hi_five/models/Emp.dart';
import 'package:uuid/uuid.dart';

class ImageUpload {
  static var uuid = const Uuid();

  static Future<void> createPost(Emp emp, String url, String user2) async {
    url = url.replaceAll("//", "/");
    print(url);
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(uuid.v1())
        .set({'image': url, 'email': emp.email, 'firstName': emp.name, 'secondName': user2});
  }
}