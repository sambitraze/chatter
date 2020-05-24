import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _formkey = GlobalKey<FormState>();
  String username;

  submit(){
    _formkey.currentState.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
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
                  child: TextFormField(
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
