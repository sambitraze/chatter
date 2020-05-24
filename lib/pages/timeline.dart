import 'package:chatter/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:chatter/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersColRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    // getUsers();
    // getUserByID();
    getuserList();
    // getUserByQuery();
    super.initState();
  }

  getuserList() async {
    final QuerySnapshot snapshot = await usersColRef.getDocuments();
    setState(() {
      users = snapshot.documents;
    });
  }

  getUserByID() {
    final String id = "C5ktOZo7zpbOlVFQCgQ5";
    usersColRef.document(id).get().then((value) => print(value.data));
  }

  getUserByQuery() async {
    final QuerySnapshot snapshot =
        await usersColRef.where("isAdmin", isEqualTo: true).getDocuments();
    snapshot.documents.forEach((element) {
      print(element.data);
    });
  }

  getUsers() {
    usersColRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((element) {
        print(element.documentID);
        print(element.data['username']);
        print(element.exists);
      });
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(),
        // backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: usersColRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                circularProgress();
              }
              final List<Text> children = snapshot.data.documents
                  .map((e) => Text(e['username']))
                  .toList();
              return Container(
                child: ListView(children: children),
              );
            }));
  }
}

// ontainer(
//         child: ListView(
//           children: users.map(
//             (e) => Text(e['username'])
//           ).toList()
//         ),
//       ),

//for getting strem
// StreamBuilder<QuerySnapshot>(
//         stream: usersColRef.snapshots(),
//         builder: (context, snapshot){
//           if(!snapshot.hasData){
//             circularProgress();
//           }
//           final List<Text> children = snapshot.data.documents.map((e) {
//             Text(e['username']);
//           }).toList();
//           return Container(
//             child: ListView(
//               children: children
//             ),
//           );
//         }

//       )

//for getting data static
