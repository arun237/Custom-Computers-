import 'package:flutter/material.dart';
import 'package:se/screens/address.dart';

import 'package:se/extensions/onhover.dart';
import 'package:se/screens/signin/signIn.dart';

class Custom extends StatefulWidget {
  Custom({Key key}) : super(key: key);

  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  TextEditingController _search = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Address()));
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
                                    color: Colors.grey[350], fontSize: 14.0),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: Row(
                      children: [
                        Text(
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
                InkWell(
                  onTap: () {},
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
    );
  }
}
