import 'package:chatter/models/user.dart';
import 'package:chatter/pages/timeline.dart';
import 'package:chatter/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  Future<QuerySnapshot> searchResultFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users = usersColRef
        .where("displayName", isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      searchResultFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for user",
          filled: true,
          prefixIcon: Icon(Icons.account_box, size: 28.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 300 : 200,
            ),
            Text(
              'Find Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 60.0),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResult() {
    return FutureBuilder(
      future: searchResultFuture,
      builder: (context, snapshot) {
        print(snapshot.toString());
        if (snapshot.hasData) {
          List<Text> searchResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocument(doc);
            searchResults.add(Text(user.username));
          });
          return ListView(
            children: searchResults,
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
      backgroundColor: Colors.white,
      appBar: buildSearchField(),
      body: searchResultFuture == null ? buildNoContent() : buildSearchResult(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}
