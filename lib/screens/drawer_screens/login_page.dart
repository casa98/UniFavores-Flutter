import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  Future<void> _createUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Firebase error: $e");
    } catch (e) {
      print("Flutter error: $e");
    }
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Firebase error: $e");
    } catch (e) {
      print("Flutter error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter email',
              ),
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text('Login'),
                  onPressed: _login,
                ),
                MaterialButton(
                  child: Text('Create new account'),
                  onPressed: _createUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
