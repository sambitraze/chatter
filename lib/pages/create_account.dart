import 'dart:async';

import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;

  submit() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text('Welcome $username'),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'Set Up Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'Create Username:',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Form(
                  key: _formkey,
                  autovalidate: true,
                  child: TextFormField(
                    validator: (val) {
                      if (val.trim().length < 6 || val.isEmpty) {
                        return "Username is too short";
                      } else if (val.trim().length > 12) {
                        return "username is too long";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => username = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        labelStyle: TextStyle(fontSize: 15.0),
                        hintText: "Must be more than 6 letters"),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: submit,
              child: Container(
                // padding: EdgeInsets.all(15.0),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
