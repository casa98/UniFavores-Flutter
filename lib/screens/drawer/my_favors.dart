import 'package:auth/services/database.dart';
import 'package:auth/shared/constants.dart';
import 'package:auth/shared/util.dart';
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
                    if (currentFavor[FAVOR_STATUS] == -1)
                      currentFavor[FAVOR_STATUS] = UNASSIGNED;
                    else if (currentFavor[FAVOR_STATUS] == 1)
                      currentFavor[FAVOR_STATUS] = ASSIGNED;
                    else
                      currentFavor[FAVOR_STATUS] = COMPLETED;

                    return ListTile(
                      title: Text(
                        currentFavor[FAVOR_TITLE],
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        children: [
                          Text(STATUS),
                          SizedBox(width: 10.0),
                          Text(
                            currentFavor[FAVOR_STATUS],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      trailing: Text(
                        Util()
                            .readFavorTimestamp(currentFavor[FAVOR_TIMESTAMP]),
                      ),
                      onTap: () {
                        if (currentFavor[FAVOR_STATUS] == UNASSIGNED) {
                          // Can be deleted
                          showDialog(
                              context: context,
                              builder: (context) {
                                return myFavorsDialog(
                                    'Delete favor',
                                    'Sure yuo want to delete this favor?',
                                    true,
                                    currentFavor[FAVOR_KEY],
                                    null);
                              });
                          //TODO Show snackbar
                        }
                        if (currentFavor[FAVOR_STATUS] == ASSIGNED) {
                          // Can be mark as completed
                          showDialog(
                              context: context,
                              builder: (context) {
                                return myFavorsDialog(
                                    'Mark as completed',
                                    'Has your peer completed this favor?',
                                    false,
                                    currentFavor[FAVOR_KEY],
                                    currentFavor[FAVOR_ASSIGNED_USER]);
                              });
                          //TODO Show snackbar
                        }
                      },
                    );
                  },
                );
              //
            }
          },
        ));
  }

  AlertDialog myFavorsDialog(String title, String text, bool delete,
      String favorId, String assignedUser) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OH NO'),
        ),
        FlatButton(
          onPressed: () {
            if (delete) {
              // Delete favor
              DatabaseService().deleteFavor(favorId);
            } else {
              // Mark as completed
              DatabaseService().markFavorAsCompleted(favorId, assignedUser);
            }
            Navigator.of(context).pop();
          },
          child: Text('YES'),
        ),
      ],
    );
  }
}
