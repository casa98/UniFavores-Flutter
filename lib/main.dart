import 'package:auth/screens/drawer/active_chats.dart';
import 'package:auth/screens/drawer/home_page.dart';
import 'package:auth/screens/drawer/incomplete_favors.dart';
import 'package:auth/screens/drawer/my_favors.dart';
import 'package:auth/screens/drawer/profile.dart';
import 'package:auth/screens/drawer/statistics.dart';
import 'package:auth/shared/constants.dart';
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
        '/home': (context) => HomePage(UNASSIGNED_FAVORS),
        '/profile': (context) => Profile(PROFILE),
        '/myFavors': (context) => MyFavors(MY_FAVORS),
        '/incompleteFavors': (context) => IncompleteFavors(INCOMPLETE_FAVORS),
        '/activeChats': (context) => ActiveChats(ACTIVE_CHATS),
        '/statistics': (context) => Statistics(STATISTICS),
      },
    );
  }
}
