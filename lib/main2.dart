import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



void main2() {
  // SystemChrome.setSystemUIOverlayStyle(
  //    SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://c236dotnet.azurewebsites.net/lesson09/api/travel/list"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    //print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Where We Were"), backgroundColor: Colors.teal),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
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
                        "http://c236dotnet.azurewebsites.net/lesson09/photos/${data[index]["picture"]}",
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        print("press " + index.toString());
                      },
                    ),*/
                    Container(
                      width: double.infinity,
                      child: Material(
                        color: Colors.teal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data[index]["title"],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
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
    );
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
