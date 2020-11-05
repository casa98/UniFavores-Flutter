import 'package:flutter/material.dart';

class ActiveChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Center(
        child: Text('Active Chats'),
      ),
    );
  }
}
