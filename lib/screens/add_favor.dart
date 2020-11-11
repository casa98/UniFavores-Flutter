import 'package:flutter/material.dart';

class AddFavor extends StatefulWidget {
  @override
  _AddFavorState createState() => _AddFavorState();
}

class _AddFavorState extends State<AddFavor> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  String _location;

  //TODO BottomSheet is overlapped by keyboard

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              child: Text(
                'Ask for a favor',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            titleFormField(),
            SizedBox(height: 20.0),
            descriptionFormField(),
            SizedBox(height: 20.0),
            deliveryPlaceFormField(),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //TODO Save favor in Firestore
                  Navigator.of(context).pop();
                }
              },
              color: Colors.blue[600],
              child: Text(
                'REQUEST FAVOR',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField titleFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) => _title = value,
      validator: (value) {
        return value.isEmpty ? 'Please enter a title' : null;
      },
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: 'Title of your favor',
        helperText: 'Be brief and concise',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      maxLength: 50,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField descriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) => _description = value,
      validator: (value) {
        return value.isEmpty ? 'Please enter a description' : null;
      },
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: 'Description of your favor',
        helperText: 'Describe what you need',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      maxLength: 300,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField deliveryPlaceFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) => _location = value,
      validator: (value) {
        return value.isEmpty ? 'Please enter a location' : null;
      },
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: 'Delivery place',
        helperText: 'Where will it be delivered',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      maxLength: 50,
    );
  }
}
