import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection Reference in the Firestore DB
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future crateUserCollection(String uid, String name) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'username': name,
      'score': 2,
    });
  }
}
