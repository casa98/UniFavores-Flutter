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
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
          ),
          _createDrawerItem(context, 'Profile', '/profile', Icons.person),
          Divider(),
          _createDrawerItem(context, 'My Favors', '/myFavors', Icons.grading),
          _createDrawerItem(
              context, 'Incomplete Favors', '/incompleteFavors', Icons.list),
          _createDrawerItem(
              context, 'Active Chats', '/activeChats', Icons.chat_outlined),
          Divider(),
          _createDrawerItem(
              context, 'Statistics', '/statistics', Icons.bar_chart),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return UserAccountsDrawerHeader(
    accountName: Text("Armando Esteban Quito"),
    accountEmail: Text("armandoestebanquito@m.com"),
    currentAccountPicture: CircleAvatar(
      backgroundColor: defaultTargetPlatform == TargetPlatform.iOS
          ? Colors.blue
          : Colors.white,
      child: Text(
        "A",
        style: TextStyle(fontSize: 40.0),
      ),
    ),
  );
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
