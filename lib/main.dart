import 'package:auth/screens/active_chats.dart';
import 'package:auth/screens/home_page.dart';
import 'package:auth/screens/incomplete_favors.dart';
import 'package:auth/screens/login_page.dart';
import 'package:auth/screens/my_favors.dart';
import 'package:auth/screens/profile.dart';
import 'package:auth/screens/statistics.dart';
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
        '/home': (context) => HomePage(),
        '/profile': (context) => Profile(),
        '/myFavors': (context) => MyFavors(),
        '/incompleteFavors': (context) => IncompleteFavors(),
        '/activeChats': (context) => ActiveChats(),
        '/statistics': (context) => Statistics(),
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
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text('Connectiong'),
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
