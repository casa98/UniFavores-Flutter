import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String passwd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createUserWithEmailAndPassword(String email, String passwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
