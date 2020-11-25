import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // Collection Reference in the Firestore DB
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  final CollectionReference favorsCollection =
      FirebaseFirestore.instance.collection('favors');

  final User currentUser = FirebaseAuth.instance.currentUser;

  Future crateUserCollection(String uid, String name) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'username': name,
      'score': 2,
    });
  }

  Future saveFavor(
    String title,
    String description,
    String location,
  ) async {
    var key = favorsCollection.doc().id;
    return await favorsCollection.doc(key).set({
      //'assignedUser': '',
      //'assignedUsername': '',
      'creationDate': 'get current time and format it',
      'favorDescription': description,
      'favorLocation': location,
      'favorTitle': title,
      'key': key,
      'status': -1, // Unassigned
      'user': currentUser.uid,
      'username': '<value_missing>'
    });
  }
}
