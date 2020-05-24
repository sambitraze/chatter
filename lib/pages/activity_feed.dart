import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text(
        'Notification',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        ),
      ),
      centerTitle: true,
    ));
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
