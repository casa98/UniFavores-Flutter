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
        stream: FirebaseFirestore.instance.collection('favors').snapshots(),
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
                      favorInfo['favorTitle'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      print(favorInfo['favorTitle']);
                    },
                    subtitle: Text(
                      favorInfo['favorDescription'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(favorInfo['creationDate']),
                  );
                }).toList(),
              );
          }
        });
  }
}
