import 'package:auth/screens/add_favor.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String _title;
  HomePage(this._title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Home'),
      ),
      floatingActionButton: _canRequestFavor()
          ? FloatingActionButton(
              onPressed: () => _addFavorModalBottomSheet(context),
              tooltip: 'Ask for a favor',
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  bool _canRequestFavor() {
    //TODO Check current user score, if >= 2, return true, else, false
    return true;
  }
}

void _addFavorModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bd) {
        return AddFavor();
      });
}
