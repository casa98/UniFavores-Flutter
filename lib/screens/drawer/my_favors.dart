import 'package:auth/shared/constants.dart';
import 'package:auth/shared/util.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFavors extends StatefulWidget {
  final String _title;
  MyFavors(this._title);

  @override
  _MyFavorsState createState() => _MyFavorsState();
}

class _MyFavorsState extends State<MyFavors> {
  var firestoreRef = FirebaseFirestore.instance
      .collection(FAVORS)
      .where(FAVOR_USER, isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .orderBy(FAVOR_TIMESTAMP, descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
        ),
        body: StreamBuilder(
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
                        Util()
                            .readFavorTimestamp(currentFavor[FAVOR_TIMESTAMP]),
                      ),
                      onTap: () {},
                    );
                  },
                );
              //
            }
          },
        ));
  }
}
