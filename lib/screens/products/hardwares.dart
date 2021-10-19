import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se/screens/cart.dart';

class Hardwares extends StatelessWidget {
  const Hardwares({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebf1fa),
      body: Hardware(),
    );
  }
}

class Hardware extends StatefulWidget {
  Hardware({Key key}) : super(key: key);

  @override
  _HardwareState createState() => _HardwareState();
}

class _HardwareState extends State<Hardware> {
  List<String> components = [
    'Processor',
    'Mother Board',
    'Ram',
    'Hard disk',
    'Monitor',
    'DVD Drive',
    'Cabinet',
    'Keyboard Mouse',
    'UPS',
    'Speaker',
    'Webcam',
    'Headphone Mic',
    'Graphics Card',
  ];
  List<dynamic> classes = ['/processor'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
            childAspectRatio: 1.5 / 1,
            shrinkWrap: true,
            crossAxisCount: 5,
            children: List.generate(
              components.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/board',
                      arguments: {'type': components[index].toLowerCase()});
                },
                child: Container(
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   scale: 0.5,
                    //   fit: BoxFit.cover,
                    //   image: AssetImage(
                    //     'images/peripherals/${components[index]}.png',
                    //   ),
                    // ),
                    // color: Color(0xffebf1fa),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      new Image(
                          // fit: BoxFit.fill,
                          height: 80,
                          image: new AssetImage(
                              'images/peripherals/${components[index]}.png')),
                      Positioned(
                        bottom: 10,
                        child: Text(components[index],
                            style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Color(0xff05214d).withOpacity(0.7),
                                fontSize: 15)),
                      )
                    ],
                  ),
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 300),
          child: Container(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'View Cart',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
