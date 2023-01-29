import 'package:cloud_firestore/cloud_firestore.dart';

class Emp {
  String name;
  String email;
  DocumentReference? reference;

  Emp(this.name, this.email, {this.reference});

  Emp.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.get('name'),
        email = snapshot.get('email'),
        reference = snapshot.reference;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
  };
}