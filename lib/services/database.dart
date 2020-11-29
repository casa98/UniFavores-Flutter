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

  Future createUserCollection(String uid, String name) async {
    return await userCollection.doc(uid).set({
      IMAGE: '',
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
    dynamic username;
    await userCollection
        .doc(currentUser.uid)
        .get()
        .then<dynamic>((snapshot) async {
      username = snapshot.data()[USERNAME];
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
        FAVOR_USERNAME: username,
      });
    });
  }

  Future markFavorAsAssigned(String favorId) async {
    dynamic username;
    await userCollection
        .doc(currentUser.uid)
        .get()
        .then<dynamic>((snapshot) async {
      username = snapshot.data()[USERNAME];
      return await favorsCollection.doc(favorId).update({
        FAVOR_STATUS: 1,
        FAVOR_ASSIGNED_USER: currentUser.uid,
        FAVOR_ASSIGNED_USERNAME: username,
      });
    });
  }

  Future<bool> canAskForFavors() async {
    var snapshot = await userCollection.doc(currentUser.uid).get();
    int userScore = snapshot.data()[SCORE];
    return userScore >= 2;
  }
}
