import 'dart:js';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se/admins/admin_login.dart';
import 'package:se/screens/choosing.dart';
import 'package:se/screens/home.dart';
import 'package:se/screens/products/products.dart';

import 'package:se/screens/signin/components/cartmodel.dart';
import 'package:se/screens/signup.dart';
import 'package:se/screens/user.dart';
import 'package:se/admins/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp;

void main() async {
  sp = await SharedPreferences.getInstance();

  sp.setBool('isloggedin', false);
  sp.setString('isfree', 'false');
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/choose": (context) => ChooseReq(),
        "/signup": (context) => SignupApp(),
        '/user': (context) => Users(),
        '/home': (context) => Home(),
        '/admin': (context) => new Admin(),
        '/loginadmin': (BuildContext context) => new LoginAdmin(),
        '/board': (context) => new Products()
      },
    );
  }
}
