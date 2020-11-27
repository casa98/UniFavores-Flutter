import 'package:auth/shared/constants.dart';
import 'package:auth/shared/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnassignedFavors extends StatefulWidget {
  @override
  _UnassignedFavorsState createState() => _UnassignedFavorsState();
}

class _UnassignedFavorsState extends State<UnassignedFavors> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(FAVORS)
          .orderBy(FAVOR_TIMESTAMP, descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                var favorInfo = document.data();
                return ListTile(
                  title: Text(
                    favorInfo[FAVOR_TITLE],
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    print(favorInfo[FAVOR_TITLE]);
                  },
                  subtitle: Text(
                    favorInfo[FAVOR_DESCRIPTION],
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                      Util().readFavorTimestamp(favorInfo[FAVOR_TIMESTAMP])),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
