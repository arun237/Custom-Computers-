import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class ChooseReq extends StatefulWidget {
  ChooseReq({Key key}) : super(key: key);

  @override
  _ChooseReqState createState() => _ChooseReqState();
}

Future<List> getData() async {
  // var url = "http://127.0.0.1:5000/getproduct";
  // final response = await http.get(url);
  // var datareceived = json.decode(response.body);
  // print(datareceived);
  List components = [
    'Processor',
    'Board',
    'Ram',
    'Hard disk',
    'Monitor',
    'DVD Drive',
    'Cabinet',
    'Keyboard & Mouse',
    'UPS',
    'Speaker',
    'Web cam',
    'Headphone & Mic',
    'Graphics Card',
  ];
  return components;
}

Future<List> getcomponents() async {
  List components = [
    'Processor',
    'Board',
    'Ram',
    'Hard disk',
    'Monitor',
    'DVD Drive',
    'Cabinet',
    'Keyboard & Mouse',
    'UPS',
    'Speaker',
    'Web cam',
    'Headphone & Mic',
    'Graphics Card',
  ];

  // datareceived.add(components);

  return components;
}

class _ChooseReqState extends State<ChooseReq> {
  List components = [
    'Processor',
    'Board',
    'Ram',
    'Hard disk',
    'Monitor',
    'DVD Drive',
    'Cabinet',
    'Keyboard & Mouse',
    'UPS',
    'Speaker',
    'Web cam',
    'Headphone & Mic',
    'Graphics Card',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.blueGrey[100],
        body: Center(
      child: Container(
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                child: FutureBuilder(
                    future: getcomponents(),
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? Cards(
                              list: snapshot.data,
                            )
                          : CircularProgressIndicator();
                    }),
              ),
              Container(
                width: 200,
                child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? Cards(
                              list: snapshot.data,
                            )
                          : Container();
                    }),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Cards extends StatelessWidget {
  final List list;
  const Cards({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list
          .map((e) => InkWell(
              onTap: () {},
              child: Card(
                color: Color(Random().nextInt(0xffffffff)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Container(
                  width: 200,
                  height: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        e,
                      ),
                    ),
                  ),
                ),
              )))
          .toList(),
    );
  }
}
