import 'dart:io';


import 'package:chill_lah/uploadImage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:chill_lah/getUserAPI.dart';

//import 'dart:async';

import 'package:http/http.dart' as http;
//import 'dart:convert';

//import 'dart:io';

import 'package:image_picker/image_picker.dart';

// input login
final inputUsername = TextEditingController();
final inputPassword = TextEditingController();

//input sign up
final signUpUsername = TextEditingController();
final signUpPassword = TextEditingController();
final signUpPassword2 = TextEditingController();
final signUpEmail = TextEditingController();
//

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.blue[200],
              Colors.blue[300],
              Colors.indigo[900]
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundImage: AssetImage('images/logo.jpg'),
                  radius: 120,
                ),
                SizedBox(height: 10),
                Text(
                  'This is an Application, which can helps to view your emotion trend by the period of time and manage some of your personal settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => _onAlertUserLogin(context), //Login
                  icon: Icon(
                    Icons.login,
                  ),
                  label: Text("Login"),
                ),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => _onAlertUserSignUp(context), // Sign Up
                  icon: Icon(
                    Icons.login,
                  ),
                  label: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_onAlertUserLogin(context) {
  Alert(
      context: context,
      title: "LOGIN",
      content: Column(
        children: <Widget>[
          TextField(
            controller: inputUsername,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: inputPassword,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            GetUserAPI.makeRequest();
            for (int i = 0; i < GetUserAPI.usernameList.length; i++) {
              if (inputUsername.text == GetUserAPI.usernameList[i] &&
                  inputPassword.text == GetUserAPI.passwordList[i]) {
                Navigator.popAndPushNamed(context, '/login');
              }
            }
          },
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_onAlertUserSignUp(context) {
  Alert(
      context: context,
      title: "SIGN UP",
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(child: UploadImage() //image
              ),
          TextField(
            controller: signUpUsername,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: signUpPassword,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
          TextField(
            controller: signUpPassword2,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Confirm Password',
            ),
          ),
          TextField(
            controller: signUpEmail,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            if(signUpPassword.text == signUpPassword2.text){
              postHttp();
              Navigator.pop(context);
            }
            else{
              print("invaild password");
            }
          },
          child: Text(
            "SIGN UP",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

void postHttp() async {
  var headers = {
    'Cookie':
        'ARRAffinity=e4e81bc7848b5fcf59c244bbca7b40027ef11e2df54552edc5b5cfc112694829'
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://c200teame.azurewebsites.net/api/demo/upload'));
  request.fields
      .addAll({'username': signUpUsername.text, 'password': signUpPassword.text, 'email': signUpEmail.text});
  request.files
      .add(await http.MultipartFile.fromPath('photo', image_1.path.toString()));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print("Sended");
  } else {
    print(response.reasonPhrase);
  }
}