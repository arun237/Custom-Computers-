import 'dart:async';
import 'package:flutter/material.dart';
import 'package:se/main.dart';
import 'package:se/screens/address.dart';
import 'package:se/screens/cart.dart';
import 'package:se/screens/myorders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:se/extensions/showup.dart';
import 'package:se/extensions/onhover.dart';
import 'package:se/screens/signin/signIn.dart';
import 'package:se/screens/user/components/desktop.dart';
import 'package:se/screens/user/components/laptop.dart';

class Users extends StatelessWidget {
  const Users({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: User_body(),
    );
  }
}

class User_body extends StatefulWidget {
  User_body({Key key}) : super(key: key);

  @override
  _User_bodyState createState() => _User_bodyState();
}

class _User_bodyState extends State<User_body> {
  TextEditingController _search = new TextEditingController();
  Color myHexColor = Color(0xff123456);
  int i = 1;
  double _opacity1 = 0;
  double _opacity2 = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var a = size.height - 100;

    // print(sp.getString("name"));

    return Container(
      color: i == 1 ? Colors.black : Colors.indigo[900],
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black,

            height: 60.0,
            // color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        child: Image(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.cover,
                          width: 40,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Image(
                        image: AssetImage("images/0.jpg"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Address()));
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "hello",
                                      style: TextStyle(
                                          color: Colors.grey[350],
                                          fontSize: 14.0),
                                    ),
                                    Text(
                                      "Select your address",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ).showOnHover.moveUp,
                      ),
                    ],
                  ),
                  SizedBox(width: 5.0),

                  Container(
                    // color: Colors.white,
                    height: 30,
                    // width: 400,

                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50.0),

                      // boxShadow: [
                      //   new BoxShadow(color: Colors.grey[100], blurRadius: 20.0)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          SizedBox(
                            width: 400,
                            child: TextField(
                              controller: _search,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Row(
                            children: [
                              sp.getString('name') != null
                                  ? Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            sp
                                                .getString('name')[0]
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[50]),
                                          ),
                                        ),
                                        Text(
                                          sp.getString('name').toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  : Text(
                                      "Hello,Sign in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                              SizedBox(
                                width: 1,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              )
                            ],
                          ).showOnHover.moveUp,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOrders()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('My Orders'),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 55,
                              child: Image(
                                image: AssetImage("images/cart.png"),
                                width: 55,
                                height: 35,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                              child: Text(
                                "Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ).showOnHover.moveUp,
                      ),
                    ],
                  ),

                  // SearchBar(),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 40,
            width: size.width,
          ),
          Container(
            height: a,
            width: size.width,
            child: Stack(
              fit: StackFit.loose,
              children: [
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _opacity1,
                  child: Container(
                      height: a,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/1.jpg"),
                            fit: BoxFit.cover),
                      )),
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _opacity2,
                  child: Container(
                      height: a,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/computer.jpg"),
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Positioned(
                  top: 200.0,
                  child: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.navigate_before_rounded),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: i == 2
                              ? () {
                                  setState(() {
                                    i = 1;
                                    _opacity2 = 1.0;
                                    _opacity1 = 0.0;
                                  });
                                }
                              : null,
                        ),
                        IconButton(
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: i != 2
                                ? () {
                                    setState(() {
                                      i = 2;
                                      _opacity2 = 0.0;
                                      _opacity1 = 1.0;
                                    });
                                  }
                                : null,
                            icon: Icon(Icons.navigate_next_rounded)),
                      ],
                    ),
                  ),
                ),
                i == 1 ? Body() : Lap(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
