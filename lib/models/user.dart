import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String id;
  final String username;
  final String photoUrl;
  final String displayName;
  final String bio;
  final String email;

  User({
    this.id,
    this.bio,
    this.displayName,
    this.email,
    this.photoUrl,
    this.username,
  });  

  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['PhotoURL'],
      displayName: doc['displayName'],
      bio: doc['bio'],
    );
  }

}
