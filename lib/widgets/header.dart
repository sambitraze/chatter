import 'package:flutter/material.dart';

AppBar header() {
  return AppBar(
    // flexibleSpace: Container(
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(colors: [
    //   Colors.green,
    //   Colors.cyan,
    // ]))),
    backgroundColor: Colors.black,
    title: Text(
      'Chatter',
      style: TextStyle(
          color: Colors.white, fontFamily: "Signatra", fontSize: 50.0),
    ),
    centerTitle: true,
  );
}
