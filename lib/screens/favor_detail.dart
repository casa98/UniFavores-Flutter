import 'package:auth/shared/constants.dart';
import 'package:flutter/material.dart';

class FavorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FAVOR_DETAILS),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[50],
            height: 120.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Colors.blue[100],
                    backgroundImage: NetworkImage(
                      '',
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(REQUESTED_BY),
                    SizedBox(height: 8.0),
                    Text(
                      'Llehison Jimenz',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DETAILS_TITLE,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text('Favor title'),
                SizedBox(height: 16.0),
                Text(
                  DETAILS_DESCRIPTION,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text('Favor description'),
                SizedBox(height: 16.0),
                Text(
                  DETAILS_DELIVERY_PLACE,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text('Favor delivery place'),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                    child: Text(DO_THIS_FAVOR),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
