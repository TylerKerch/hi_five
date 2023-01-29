import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String username;
  String profileURL;
  DocumentReference? reference;

  User(this.name, this.username, this.profileURL, {this.reference});

  User.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.get('name'),
        username = snapshot.get('username'),
        profileURL = snapshot.get('profileURL'),
        reference = snapshot.reference;

  Map<String, dynamic> toJson() => {
    'name': name,
    'username': username,
    'profileURL' : profileURL,
  };
}