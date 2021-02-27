import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUserAPI {
  static int dateLength;
  static var data;
  static var usernameList = new List();
  static var passwordList = new List();
  static var emailList = new List();
  static var imageName = new List();
  static var all_data;
  static String url = 'http://c200teame.azurewebsites.net/api/demo';

  static Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var extractdata = json.decode(response.body);
    all_data = extractdata;
    dateLength = extractdata.length;

    print(dateLength);

    for (int i = 0; i < extractdata.length; i++) {
      data = all_data[i];
      usernameList.add(data['userName']);
      passwordList.add(data['password']);
      emailList.add(data['email']);
      imageName.add(data['image']);
    }
  }
}
