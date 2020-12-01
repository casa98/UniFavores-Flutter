import 'package:auth/screens/add_favor.dart';
import 'package:auth/screens/drawer/unassigned_favors.dart';
import 'package:auth/shared/constants.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    var firestoreRef = FirebaseFirestore.instance
        .collection(USER)
        .doc(FirebaseAuth.instance.currentUser.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: UnassignedFavors(),
      ),
      floatingActionButton: StreamBuilder(
        stream: firestoreRef.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('');
            default:
              var userScore = snapshot.data[SCORE];
              return userScore >= 2
                  ? FloatingActionButton(
                      onPressed: () => _addFavorModalBottomSheet(context),
                      tooltip: ASK_FOR_A_FAVOR,
                      child: Icon(Icons.add),
                    )
                  : Text('');
          }
        },
      ),
    );
  }
}

void _addFavorModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext bd) {
        return AddFavor();
      });
}
