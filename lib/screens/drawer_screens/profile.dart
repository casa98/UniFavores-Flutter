import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  final String _title;
  Profile(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.red,
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
