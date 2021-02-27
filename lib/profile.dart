import 'package:flutter/material.dart';
import 'package:chill_lah/getUserAPI.dart';
import 'package:chill_lah/welcome.dart';
import 'package:chill_lah/uploadImage.dart';

import 'dart:async';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  getname() {
    for (int i = 0; i < GetUserAPI.usernameList.length; i++) {
      if (inputUsername.text == GetUserAPI.usernameList[i]) {
        return GetUserAPI.usernameList[i].toString();
      }
    }
  }

  getemail() {
    for (int i = 0; i < GetUserAPI.usernameList.length; i++) {
      if (inputUsername.text == GetUserAPI.usernameList[i]) {
        return GetUserAPI.emailList[i].toString();
      }
    }
  }

  getImage() {
    for (int i = 0; i < GetUserAPI.usernameList.length; i++) {
      if (inputUsername.text == GetUserAPI.usernameList[i]) {
        return GetUserAPI.imageName[i].toString();
      }
    }
  }

  @override
  bool showPassword = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://c200teame.azurewebsites.net/candidates/' +
                                  getImage()),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.blue,
                    //       border: Border.all(
                    //         width: 1,
                    //         color: Theme.of(context).scaffoldBackgroundColor,
                    //       ),
                    //     ),
                    //     height: 40,
                    //     width: 40,
                    //     child: IconButton(
                    //       icon: Icon(Icons.edit),
                    //       color: Colors.white, 
                    //       onPressed: () => UploadImage(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('username:'),
                      Text(
                        getname(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: customTextField("Email", getemail(), false),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: customTextField("Password", "********", true),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      onPressed: () {},
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField customTextField(String labeltext, String placeholder, bool isPass) {
    return TextField(
      obscureText: isPass ? showPassword : false,
      decoration: InputDecoration(
        suffixIcon: isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
              )
            : null,
        labelText: labeltext,
        hintText: placeholder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
