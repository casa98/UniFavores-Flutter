import 'package:auth/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  AuthService _auth = AuthService();

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
                  onPressed: () {
                    _auth.signInWithEmailAndPassword(_email, _password);
                  },
                ),
                MaterialButton(
                  child: Text('Create new account'),
                  onPressed: () {
                    _auth.createUserWithEmailAndPassword(_email, _password);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
