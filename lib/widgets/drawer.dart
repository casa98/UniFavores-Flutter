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
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
            leading: Icon(Icons.person),
          ),
          Divider(),
          ListTile(
            title: Text('My Favors'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/myFavors');
            },
            leading: Icon(Icons.grading),
          ),
          ListTile(
            title: Text('Incomplete Favors'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/incompleteFavors');
            },
            leading: Icon(Icons.list),
          ),
          ListTile(
            title: Text('Active Chats'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/activeChats');
            },
            leading: Icon(Icons.chat_outlined),
          ),
          Divider(),
          ListTile(
            title: Text('Statistics'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/statistics');
            },
            leading: Icon(Icons.bar_chart),
          ),
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
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Text(text),
    leading: Icon(icon),
    onTap: onTap,
  );
}
