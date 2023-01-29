import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hi_five/models/Emp.dart';
import 'package:uuid/uuid.dart';

class ImageUpload {
  static var uuid = const Uuid();

  static Future<void> createPost(Emp emp, String url) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(uuid.v1())
        .set({'image': url, 'email': emp.email, 'firstName': emp.name, 'secondName': emp.pairing});
  }

  static Future<List<DocumentSnapshot>> getAllPosts() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('posts').get();
    List<DocumentSnapshot> docs = snapshot.docs;
    return docs;
  }

}