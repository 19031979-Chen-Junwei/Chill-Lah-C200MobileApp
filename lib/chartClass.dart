//import 'dart:js';

import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:chill_lah/welcome.dart';
import 'package:chill_lah/loginhome.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Chart2 extends StatefulWidget {
  const Chart2({Key key}) : super(key: key);

  @override
  _Chart2State createState() => _Chart2State();
}

double anger = 0.0;
double contempt = 0.0;
double disgust = 0.0;
double fear = 0.0;
double happiness = 0.0;
double neutral = 0.0;
double sadness = 0.0;
double surprise = 0.0;

class _Chart2State extends State<Chart2> {
  List data;

  Map<String, double> dataMap = {
    "Anger": anger,
    "Contempt": contempt,
    "Disgust": disgust,
    "Fear": fear,
    "Happiness": happiness,
    "Neutral": neutral,
    "Sadness": sadness,
    "Surprise": surprise,
  };

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://c200teame.azurewebsites.net/api/emotionuser/" +
            inputUsername.text),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      int i = data.length - 1;
      dataMap = {
        "Anger": data[i]['anger'].toDouble(),
        "Contempt": data[i]['contempt'].toDouble(),
        "Disgust": data[i]['disgust'].toDouble(),
        "Fear": data[i]['fear'].toDouble(),
        "Happiness": data[i]['happiness'].toDouble(),
        "Neutral": data[i]['neutral'].toDouble(),
        "Sadness": data[i]['sadness'].toDouble(),
        "Surprise": data[i]['surprise'].toDouble(),
      };
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getData,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'This the a Pie Chart\n for the newest data',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(seconds: 2),
              chartLegendSpacing: 55,
              chartRadius: 180,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 70,
              centerText: "Emotion Data",
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
