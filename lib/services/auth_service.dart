import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hi_five/models/User.dart';

class AuthService {
  void signInWithEmail(String email, String password) {
    auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<List<String>> getAllUsernames() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> docs = snapshot.docs;
    List<String> usernames = [];

    for (DocumentSnapshot doc in docs) {
      usernames.add(doc.get('username'));
    }

    return usernames;
  }

  Future<bool> signUpWithEmail(
      String name, String username, String email, String password) async {
    try {
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> createUser(User user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
  }

  Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}