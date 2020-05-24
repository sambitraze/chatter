import 'package:chatter/pages/activity_feed.dart';
import 'package:chatter/pages/profile.dart';
import 'package:chatter/pages/search.dart';
import 'package:chatter/pages/timeline.dart';
import 'package:chatter/pages/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'create_account.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersColRef = Firestore.instance.collection('users');
final DateTime uct = DateTime.now();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  bool isAuth = false;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      handleSignIn(account);
    }, onError: (e) {
      print(e.toString());
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((e) {
      print(e.toString());
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print(account.displayName);
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    //chk if users exist in users collection according to thier id
    final GoogleSignInAccount user = googleSignIn.currentUser;
    print(user.id);
    final DocumentSnapshot doc = await usersColRef.document(user.id).get();
    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      usersColRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "PhotoURL": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "UCT": uct,
      });
    }
    // if not then to create account page.

    //get user name froma ccount make new user document users collecion
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
          RaisedButton(
            onPressed: logout,
            color: Colors.white,
            child: Text('Log Out'),
          ),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: (pageIndex) {
          setState(() {
            this.pageIndex = pageIndex;
          });
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        color: Colors.black,
        backgroundColor: Colors.white,
        onTap: onTap,
        items: <Widget>[
          Icon(
            Icons.whatshot,
            size: 30,
            color: Colors.redAccent,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.greenAccent,
          ),
          Icon(
            Icons.add_a_photo,
            size: 30,
            color: Colors.orangeAccent,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.purpleAccent,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
    // return RaisedButton(onPressed: logout, child: Text('Log Out'),);
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chatter',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
