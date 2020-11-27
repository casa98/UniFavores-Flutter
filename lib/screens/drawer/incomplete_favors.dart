import 'package:auth/shared/constants.dart';
import 'package:flutter/material.dart';

class IncompleteFavors extends StatelessWidget {
  final String _title;
  IncompleteFavors(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Text(INCOMPLETE_FAVORS),
      ),
    );
  }
}
