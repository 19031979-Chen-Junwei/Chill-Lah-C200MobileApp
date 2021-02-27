

import 'package:chill_lah/profile.dart';
import 'package:flutter/material.dart';
import 'package:chill_lah/welcome.dart';
import 'package:chill_lah/loginhome.dart';
import 'package:chill_lah/settingpage.dart';
import 'package:chill_lah/main2.dart';
import 'package:chill_lah/homepage2.dart';
import 'package:chill_lah/chartClass.dart';
import 'package:chill_lah/chartClass.dart';
import 'package:chill_lah/uploadImage.dart';


void main() => runApp(MaterialApp(
    routes: {
    '/':(context) => Welcome(),
    '/login':(context) => LoginHome(),
    '/profile':(context) => Profile(),
    '/setting':(context) => Setting()
  },
));
