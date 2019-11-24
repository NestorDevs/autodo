import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreBLoC {
  static final Firestore _db = Firestore.instance;
  static DocumentReference userDoc;

  Future<void> createUserDocument(String uuid) async {
    userDoc = _db.collection('users').document(uuid);
    while (true) {
      // only return from this function when we've successfully created 
      // the new user document
      try {
        await userDoc.setData(Map<String, Object>());
      } catch (e) {
        continue;
      }
      return;
    }
  }

  void setUserDocument(String uuid) {
    userDoc = _db.collection('users').document(uuid);
  }

  DocumentReference getUserDocument() {
    return userDoc;
  }

  void deleteUserDocument() {
    userDoc.delete();
  }

  // Make the object a Singleton
  static final FirestoreBLoC _auth = FirestoreBLoC._internal();
  factory FirestoreBLoC() {
    return _auth;
  }
  FirestoreBLoC._internal();
}