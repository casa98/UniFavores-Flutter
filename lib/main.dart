import 'package:auth/screens/drawer_screens/active_chats.dart';
import 'package:auth/screens/drawer_screens/home_page.dart';
import 'package:auth/screens/drawer_screens/incomplete_favors.dart';
import 'package:auth/screens/drawer_screens/my_favors.dart';
import 'package:auth/screens/drawer_screens/profile.dart';
import 'package:auth/screens/drawer_screens/statistics.dart';
import 'package:auth/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Wrapper(),
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
