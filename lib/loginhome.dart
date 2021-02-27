import 'package:flutter/material.dart';
import 'package:chill_lah/welcome.dart';
import 'package:chill_lah/getUserAPI.dart';
import 'package:chill_lah/homepage2.dart';
import 'package:chill_lah/main2.dart';
import 'package:chill_lah/chartClass.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  getname() {
    for (int i = 0; i < GetUserAPI.usernameList.length; i++) {
      if (inputUsername.text == GetUserAPI.usernameList[i]) {
        return GetUserAPI.usernameList[i].toString();
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
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text("Home"), icon: Icon(Icons.home)),
              Tab(child: Text("Chart"), icon: Icon(Icons.pie_chart)),
            ],
          ),
          title: Text('Chill Lah'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'http://c200teame.azurewebsites.net/candidates/' +
                                getImage()),
                        radius: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          getname(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[200],
                      Colors.blue[300],
                      Colors.indigo[900]
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              ListTile(
                title: Text("Profile"),
                onTap: () => {Navigator.pushNamed(context, '/profile')},
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () => Navigator.popUntil(context, ModalRoute.withName('/'))
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage2(),
            //Trend(),
            Chart2(),
          ],
        ),
      ),
    ));
  }
}
