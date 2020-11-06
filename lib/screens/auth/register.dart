import 'package:auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _confirmPassword;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildUsernameFormField(),
                  SizedBox(height: 20.0),
                  buildEmailFormField(),
                  SizedBox(height: 20.0),
                  buildPasswordFormField(),
                  SizedBox(height: 20.0),
                  buildConfirmPasswordFormField(),
                  SizedBox(height: 20.0),
                  submitButton(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () => widget.toggleView(),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onChanged: (value) => _name = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (value.length < 5) {
            return 'Please enter a longer name (>4)';
          }
        } else {
          return 'Please enter a name';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => _email = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (!EmailValidator.validate(value)) {
            return 'Please enter a valid email';
          }
        } else {
          return 'Please enter an email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) => _password = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (value.length < 6) {
            return 'Please enter a longer password (>5)';
          }
        } else {
          return 'Please enter a password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) => _confirmPassword = value,
      validator: (value) {
        if (value.isNotEmpty) {
          if (value.length < 6) {
            return 'Please enter a longer password (>5)';
          }
        } else {
          return 'Please repeat you password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Repeat password",
        hintText: "Confirm your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          if (_password == _confirmPassword) {
            _auth.createUserWithEmailAndPassword(_email, _password);
          }
        }
      },
      child: Text('Register'),
    );
  }
}
