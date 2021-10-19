import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<List> getData() async {
//   var url = "http://127.0.0.1:5000/get";
//   final response = await http.get(url);
//   var datareceived = json.decode(response.body);
//   print(datareceived);
//   return datareceived;
// }

class Admin extends StatefulWidget {
  Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
        // future: ,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error in loading...' + snapshot.error.toString());
          }
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Text(list[i]['username']
                    .toString()
                    .substring(0, 1)
                    .toUpperCase()),
              ),
              onTap: () {
                print('edit /delete');
              },
              // leading: CircleAvatar(
              //   child: Text(
              //       list[i]['NAME'].toString().substring(0, 1).toUpperCase()),
              // ),
              title: new Text(
                list[i]['username'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: new Text(list[i]["email"]),
            ),
          ),
        );
      },
    );
  }
}
