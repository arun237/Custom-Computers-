import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:se/admins/firstpage.dart';

class LoginAdmin extends StatefulWidget {
  LoginAdmin({Key key}) : super(key: key);

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  TextEditingController _txtFullName = new TextEditingController();
  TextEditingController _txtpassword = new TextEditingController();
  bool _isname = true;
  bool _ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _txtFullName,
                    decoration: new InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(fontSize: 17.0),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: 17.0),
                      errorText: _isname ? null : "Username is not correct",
                    ),
                  ),
                  TextField(
                    controller: _txtpassword,
                    decoration: new InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 17.0),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 17.0),
                      errorText: _ispassword ? null : "password is not correct",
                    ),
                  ),
                  LayoutBuilder(builder: (context, Constraints) {
                    return ButtonBar(
                      children: [
                        ElevatedButton(
                          // color: Colors.green,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: Text('Login'),
                          onPressed: () {
                            setState(() {
                              _txtFullName.text == "Arunhari"
                                  ? _isname = true
                                  : _isname = false;
                              _txtpassword.text == '10'
                                  ? _ispassword = true
                                  : _ispassword = false;
                            });

                            if (_isname == true && _ispassword == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstPage()));
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text('Clear'),
                          onPressed: () {
                            _txtFullName.clear();
                            _txtpassword.clear();
                            // Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
