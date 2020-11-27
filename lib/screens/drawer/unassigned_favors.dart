import 'package:auth/shared/constants.dart';
import 'package:auth/shared/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UnassignedFavors extends StatefulWidget {
  @override
  _UnassignedFavorsState createState() => _UnassignedFavorsState();
}

class _UnassignedFavorsState extends State<UnassignedFavors> {
  var firestoreRef = FirebaseFirestore.instance
      .collection(FAVORS)
      .orderBy(FAVOR_TIMESTAMP, descending: true);
  final User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            List item = [];
            snapshot.data.docs.forEach((element) {
              if (element.data()['user'].toString() != currentUser.uid)
                item.add(element.data());
            });
            return ListView.separated(
              itemCount: item.length,
              separatorBuilder: (context, index) => Divider(height: 0.0),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    item[index][FAVOR_TITLE],
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(item[index][FAVOR_DESCRIPTION],
                      overflow: TextOverflow.ellipsis),
                  trailing: Text(
                    Util().readFavorTimestamp(item[index][FAVOR_TIMESTAMP]),
                  ),
                  onTap: () {
                    print(item[index][FAVOR_TITLE]);
                  },
                );
              },
            );
        }
      },
    );
  }
}
