import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  Upload({this.currentUser});
  final User currentUser;

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File image;
  bool isUploading = false;

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.image = file;
    });
  }

  handleGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      this.image = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(
            'Select Image',
            style: TextStyle(fontSize: 25),
          ),
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.cyan,
                  size: 35.0,
                ),
                onPressed: handleTakePhoto,
                label: Text(
                  'Open Camera',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.perm_media,
                  color: Colors.redAccent,
                  size: 35.0,
                ),
                onPressed: handleGallery,
                label: Text(
                  'Open Gallery',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
              label: Text(
                'close',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Container buildSplashScreen() {
    return Container(
      color: Colors.orangeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/images/upload.svg'),
          RaisedButton(
            onPressed: () => selectImage(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              'Upload Image',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
  handlePost() {

  }

  buildUploadForm() {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              image = null;
            });
          },
        ),
        centerTitle: true,
        title: Text(
          "Create Post",
          style: TextStyle(color: Colors.black),
        ),        
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(image),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: "Write a caption",
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.white,
              size: 35,
            ),
            title: Container(
              alignment: Alignment.center,
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: "Location where photo was taken",
                    border: InputBorder.none),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.all(18),
              color: Colors.red,
              onPressed: () => print('sad'),
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
                size: 25,
              ),
              label: Text(
                "Get Location",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.center,
            child: ClipOval(
              child: Material(
                color: Colors.black, // button color
                child: InkWell(
                  // splashColor: Colors.redAccent, // inkwell color
                  child: SizedBox(width: 76, height: 76, child: Icon(Icons.send, color: Colors.white, size: 35,),),
                  onTap: isUploading ? null :  () => handlePost(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return image == null ? buildSplashScreen() : buildUploadForm();
  }
}
