import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Placed extends StatelessWidget {
  const Placed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Order\nPlaced Successfully',
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black.withOpacity(0.6),
            letterSpacing: 0.5),
      ),
    );
  }
}
