import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:se/admins/products.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductsReg()));
          },
          child: SizedBox(
            width: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Products"),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
