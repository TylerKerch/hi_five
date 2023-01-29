import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hi_five/models/Emp.dart';

class AuthService {
  void signInWithEmail(String email, String password) {
    auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<List<String>> getAllEmails() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> docs = snapshot.docs;
    List<String> emails = [];

    for (DocumentSnapshot doc in docs) {
      emails.add(doc.get('email'));
    }
    return emails;
  }


  static Future<List<String>> getAllOtherNames(String email) async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> docs = snapshot.docs;
    List<String> names = [];

    for (DocumentSnapshot doc in docs) {
      if(doc.get('email') != email){
        names.add(doc.get('name'));
      }
    }
    return names;
  }

  static Future<bool> postedToday(String id) async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').doc(id).get();
    print(snapshot['postedToday']);
    return snapshot['postedToday'];
  }

  static Future<void> setPostedToday(String id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set({'postedToday': true}, SetOptions(merge: true));
  }

  Future<bool> signUpWithEmail(
      String name, String email, String password) async {
    try {
      print(email);
      print(password);
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> createUser(Emp emp) async {
    print(emp.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.FirebaseAuth.instance.currentUser!.uid)
        .set({'name': emp.name, 'email': emp.email, 'postedToday': false});
  }

  static Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}