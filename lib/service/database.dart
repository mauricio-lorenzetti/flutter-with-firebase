import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String analysisStatus, String cpf, String email,
      String name, String phone) async {
    return await usersCollection.doc(this.uid).set({
      'analysisStatus': analysisStatus,
      'cpf': cpf,
      'email': email,
      'name': name,
      'phone': phone
    });
  }

  // get users stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
