import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
