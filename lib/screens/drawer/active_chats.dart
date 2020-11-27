import 'package:auth/shared/constants.dart';
import 'package:flutter/material.dart';

class ActiveChats extends StatelessWidget {
  final String _title;
  ActiveChats(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Text(ACTIVE_CHATS),
      ),
    );
  }
}
