import 'dart:ui';

import 'package:auth/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          ListTile(
            title: Text(HOME),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
          ),
          _createDrawerItem(context, PROFILE, '/profile', Icons.person),
          Divider(),
          _createDrawerItem(context, MY_FAVORS, '/myFavors', Icons.list),
          _createDrawerItem(
              context, INCOMPLETE_FAVORS, '/incompleteFavors', Icons.grading),
          _createDrawerItem(
              context, ACTIVE_CHATS, '/activeChats', Icons.chat_outlined),
          Divider(),
          _createDrawerItem(
              context, STATISTICS, '/statistics', Icons.bar_chart),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  var firestoreRef = FirebaseFirestore.instance
      .collection(USER)
      .doc(FirebaseAuth.instance.currentUser.uid);
  return StreamBuilder(
    stream: firestoreRef.snapshots(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Text('Loading...');
        default:
          var userDocument = snapshot.data;
          return UserAccountsDrawerHeader(
            accountName: Text(userDocument[USERNAME]),
            accountEmail: Text(userDocument[EMAIL]),
            currentAccountPicture: CircleAvatar(
                backgroundColor: defaultTargetPlatform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: userDocument[IMAGE] == ''
                    ? Text(
                        lettersForHeader(userDocument[USERNAME]),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : CircleAvatar(
                        maxRadius: 40,
                        backgroundImage: NetworkImage(userDocument[IMAGE]),
                      )),
          );
      }
    },
  );
}

// If name == 'Maria Fernanda Garizabalo', returns 'M G'
String lettersForHeader(String name) {
  List<String> words = name.split(' ');
  if (words.length > 1) return words[0][0] + words[words.length - 1][0];
  return words[0][0];
}

Widget _createDrawerItem(
    BuildContext context, String title, String route, IconData icon) {
  return ListTile(
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
    leading: Icon(icon),
  );
}
