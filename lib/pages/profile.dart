import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatter/models/user.dart';
import 'package:chatter/pages/home.dart';
import 'package:chatter/widgets/progress.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({this.profileId});
  final String profileId;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  buildProfileButton() {
    return Text('Button');
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: usersColRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = User.fromDocument(snapshot.data);
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(user.photoUrl),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildCountColumn("Posts", 0),
                              buildCountColumn("Followers", 0),
                              buildCountColumn("Following", 0),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildProfileButton(),
                            ],
                          )
                        ],
                      ),
                      flex: 1,
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:12),
                  child: Text(user.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),                  
                ),),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:4),
                  child: Text(user.displayName, style: TextStyle(fontWeight: FontWeight.bold),                  
                ),),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:2),
                  child: Text(user.bio),  
                ),
              ],
            ),
          );
        } else {
          return circularProgress();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          buildProfileHeader(),
        ],
      ),
    );
  }
}
