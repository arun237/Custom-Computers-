import 'package:flutter/material.dart';
import 'package:se/extensions/showup.dart';
import 'package:se/screens/choosing.dart';
import 'package:se/screens/products/hardwares.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowUp(
      delay: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150.0,
            ),
            Text("Desktop".toUpperCase(),
                style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    fontFamily: "g")),
            Text(
              "Choose your own customized \nDesktop",
              style:
                  TextStyle(fontSize: 17, color: Colors.grey.withOpacity(0.70)),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Hardwares()));
              },
              child: FittedBox(
                child: Container(
                  height: 50,
                  width: 170,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Get started".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "akaya",
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
