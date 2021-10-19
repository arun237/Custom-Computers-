import 'package:flutter/material.dart';
import 'package:se/extensions/showup.dart';
import 'package:se/extensions/onhover.dart';
import 'package:se/sessions/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int delayamount = 200;
    Color myHexColor = Color(0xff123456);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 250,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      color: Colors.blueGrey[200],
                      spreadRadius: 4)
                ],
                color: myHexColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 30, color: Colors.white),
                child: ShowUp(
                  child: Text('Computer Customization ',
                      style: TextStyle(fontFamily: 'dafoe', fontSize: 40)),
                  delay: delayamount,
                ),
              ),
            ),
          ),
          SizedBox(height: 100),
          ShowUp(
            delay: delayamount,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * (1 / 17),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Counter()));
                      },
                      child: Text(
                        "Admin",
                        style: TextStyle(color: Colors.red),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red))),
                      )),
                ).showOnHover.moveUp,
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  width: size.width * (1 / 16),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/user");
                      },
                      child: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.red)))),
                ).showOnHover.moveUp,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
