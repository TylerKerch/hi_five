import 'package:cloud_firestore/cloud_firestore.dart';

class Emp {
  String name;
  String email;
  String pairing;
  DocumentReference? reference;

  Emp(this.name, this.email, this.pairing, {this.reference});

  Emp.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.get('name'),
        email = snapshot.get('email'),
        pairing = snapshot.get('pairing'),
        reference = snapshot.reference;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
  };
}