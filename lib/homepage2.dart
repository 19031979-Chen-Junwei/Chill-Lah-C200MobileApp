import 'dart:async';
import 'dart:convert';

import 'package:chill_lah/welcome.dart';
import 'package:chill_lah/loginhome.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main2() {
  // SystemChrome.setSystemUIOverlayStyle(
  //    SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(new MaterialApp(home: new HomePage2()));
}

class HomePage2 extends StatefulWidget {
  @override
  HomePage2State createState() => new HomePage2State();
}

class HomePage2State extends State<HomePage2> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://c200teame.azurewebsites.net/api/emotionuser/" +
            inputUsername.text),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  var highest = 0;
  Future<int> getHighest() async {
    for (var i = 0; i < data.length; i++) {
      if (highest < i) {
        highest = i;
      } else {
        highest = highest;
      }
    }
    print("H: " + highest.toString());
    return highest;
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      getHighest();

      return Scaffold(
        //appBar: AppBar(title: Text("Most Recent:"), backgroundColor: Colors.blue),
        body: RefreshIndicator(
          onRefresh: getData,
          child: ListView.builder(
            itemCount: data == null ? 0 : 1,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Column(
                      children: <Widget>[
                        /* GestureDetector(
                        child: Image.network(
                          "http://http://teame.azurewebsites.net/api/emotionuser/${data[index]["image"]}",
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        onTap: () {
                          print("press " + index.toString());
                        },
                      ),*/
                        Text(
                          'Most Recent Emotion Data',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Based on the newest record the user has an emotions result of:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Material(
                            color: Colors.green[400],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                //"ID: " + data[highest]["id"].toString() +'\n'+
                                "Anger: " +
                                    data[highest]["anger"].toString() +
                                    '\n' +
                                    "Contempt: " +
                                    data[highest]["contempt"].toString() +
                                    '\n' +
                                    "Disgust: " +
                                    data[highest]["disgust"].toString() +
                                    '\n' +
                                    "Fear: " +
                                    data[highest]["fear"].toString() +
                                    '\n' +
                                    "Happiness: " +
                                    data[highest]["happiness"].toString() +
                                    '\n' +
                                    "Neutral: " +
                                    data[highest]["neutral"].toString() +
                                    '\n' +
                                    "Sadness: " +
                                    data[highest]["sadness"].toString() +
                                    '\n' +
                                    "Surprise: " +
                                    data[highest]["surprise"].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 21),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

// child: Column(
//               children: <Widget>[
//                 Text(data[index]["title"]),
//                 Container(
//                     //       child: Image.network("http://c236w09.azurewebsites.net/photos/7087481e-0763-4d1d-9896-be5bc0f1c269.jpg",
//                     child: Image.network(
//                   "http://c236w09.azurewebsites.net/photos/" +
//                       data[index]["picture"],
//                   fit: BoxFit.fill,
//                   height: 80.0,
//                 )),
//                 Text(data[index]["city"]),
//                 Text(data[index]["tripDate"]),
//                 Text(data[index]["spending"].toString()),
//               ],
//             ),
