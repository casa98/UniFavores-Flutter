import 'package:auth/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // Collection Reference in the Firestore DB
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(USER);

  final CollectionReference favorsCollection =
      FirebaseFirestore.instance.collection(FAVORS);

  final User currentUser = FirebaseAuth.instance.currentUser;

  Future crateUserCollection(String uid, String name) async {
    return await userCollection.doc(uid).set({
      UID: uid,
      USERNAME: name,
      SCORE: 2,
    });
  }

  Future saveFavor(
    String title,
    String description,
    String location,
  ) async {
    var key = favorsCollection.doc().id;
    return await favorsCollection.doc(key).set({
      //FAVOR_ASSIGNED_USER: '',
      //FAVOR_ASSIGNED_USERNAME: '',
      FAVOR_TIMESTAMP: DateTime.now().millisecondsSinceEpoch,
      FAVOR_DESCRIPTION: description,
      FAVOR_LOCATION: location,
      FAVOR_TITLE: title,
      FAVOR_KEY: key,
      FAVOR_STATUS: -1, // Unassigned
      FAVOR_USER: currentUser.uid,
      FAVOR_USERNAME: '<value_missing>'
    });
  }
}
