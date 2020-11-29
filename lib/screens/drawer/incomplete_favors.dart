import 'package:auth/shared/constants.dart';
import 'package:auth/shared/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncompleteFavors extends StatefulWidget {
  final String _title;
  IncompleteFavors(this._title);

  @override
  _IncompleteFavorsState createState() => _IncompleteFavorsState();
}

class _IncompleteFavorsState extends State<IncompleteFavors> {
  var firestoreRef = FirebaseFirestore.instance
      .collection(FAVORS)
      .where(FAVOR_STATUS, isEqualTo: 1)
      .where(FAVOR_ASSIGNED_USER,
          isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .orderBy(FAVOR_TIMESTAMP, descending: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
          child: StreamBuilder(
        stream: firestoreRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData)
            return Text('You haven\'t requested any favor yet');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              List item = [];
              snapshot.data.docs.forEach((element) {
                item.add(element.data());
              });
              //
              return ListView.separated(
                itemCount: item.length,
                separatorBuilder: (context, index) => Divider(height: 0.0),
                itemBuilder: (context, index) {
                  var currentFavor = item[index];
                  return ListTile(
                    title: Text(
                      currentFavor[FAVOR_TITLE],
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(currentFavor[FAVOR_DESCRIPTION],
                        overflow: TextOverflow.ellipsis),
                    trailing: Text(
                      Util().readFavorTimestamp(currentFavor[FAVOR_TIMESTAMP]),
                    ),
                    onTap: () {},
                  );
                },
              );
            //
          }
        },
      )),
    );
  }
}
