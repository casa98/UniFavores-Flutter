import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final String _title;
  Statistics(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Text('Statistics'),
      ),
    );
  }
}
