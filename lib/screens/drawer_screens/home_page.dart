import 'package:auth/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String _title;
  HomePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
