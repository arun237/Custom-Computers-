import 'package:flutter/material.dart';

class Stackcontainer extends StatelessWidget {
  const Stackcontainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 60,
              width: 60,
              color: Colors.purple,
            ),
          ),
          Positioned(
            right: 0,
            top: 50,
            child: Container(
              height: 40,
              width: 40,
              color: Colors.red,
            ),
          ),
          Container(
            height: 20,
            width: 20,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
