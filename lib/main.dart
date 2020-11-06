import 'package:auth/screens/drawer_screens/active_chats.dart';
import 'package:auth/screens/drawer_screens/home_page.dart';
import 'package:auth/screens/drawer_screens/incomplete_favors.dart';
import 'package:auth/screens/drawer_screens/login_page.dart';
import 'package:auth/screens/drawer_screens/my_favors.dart';
import 'package:auth/screens/drawer_screens/profile.dart';
import 'package:auth/screens/drawer_screens/statistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => HomePage('Unassigned Favors'),
        '/profile': (context) => Profile('Profile'),
        '/myFavors': (context) => MyFavors('My Favors'),
        '/incompleteFavors': (context) => IncompleteFavors('Incomplete Favors'),
        '/activeChats': (context) => ActiveChats('Active Chats'),
        '/statistics': (context) => Statistics('Statistics'),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // Successfully connected to our app
          return StreamBuilder(
              // Something like LiveData? I think so
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User user = snapshot.data;
                  if (user == null) {
                    return LoginPage();
                  } else {
                    return HomePage('Unassigned Favors');
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text('Connecting'),
                  ),
                );
              });
        }
        // Still connecting (loaidng)
        return Center(
          child: Text('Connecting'),
        );
      },
    );
  }
}
