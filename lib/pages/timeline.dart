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

  @override
  void initState() {
    
    super.initState();
  }

  

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(),
        // backgroundColor: Colors.black,
        body: Container(child: null,)
    );
  }
}


  // List<dynamic> users = [];

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
// getUsers();
    // getUserByID();
    // getuserList();
    // deleteUser();
    // updateUser();
    // createUser();
    // getUserByQuery();

    // updateUser() {
  //   usersColRef.document("sddhsiafhjksf").updateData({
  //     "username": "firday",
  //   });
  // }
  // getuserList() async {
  //   final QuerySnapshot snapshot = await usersColRef.getDocuments();
  //   setState(() {
  //     users = snapshot.documents;
  //   });
  // }

  // getUserByID() {
  //   final String id = "C5ktOZo7zpbOlVFQCgQ5";
  //   usersColRef.document(id).get().then((value) => print(value.data));
  // }

  // getUserByQuery() async {
  //   final QuerySnapshot snapshot =
  //       await usersColRef.where("isAdmin", isEqualTo: true).getDocuments();
  //   snapshot.documents.forEach((element) {
  //     print(element.data);
  //   });
  // }

  // getUsers() {
  //   usersColRef.getDocuments().then((snapshot) {
  //     snapshot.documents.forEach((element) {
  //       print(element.documentID);
  //       print(element.data['username']);
  //       print(element.exists);
  //     });
  //   });
  // }

  // createUser() async {
  //   await usersColRef.add({
  //     "username": "jarvis",
  //     "postCount": 4,
  //     "isAdmin": false,
  //   });
  //   usersColRef.document("sddhsiafhjksf").setData({
  //     "username": "karin",
  //     "postCount": 7,
  //     "isAdmin": false,
  //   });
  // }

  

  // // new method
  // updateUser() async{
  //   final DocumentSnapshot doc = await usersColRef.document("C5ktOZo7zpbOlVFQCgQ5").get();
  //   if(doc.exists){
  //     doc.reference.updateData({
  //     "username": "firday",
  //   });
  //   }
  // }
  // deleteUser(){
  //    usersColRef.document("sddhsiafhjksf").delete();
  // }