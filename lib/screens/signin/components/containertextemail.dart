import 'package:flutter/material.dart';

class Containertextfield extends StatelessWidget {
  const Containertextfield({
    Key key,
    @required this.color,
    @required this.hinttext,
    @required this.size,
    @required TextEditingController email,
  })  : _email = email,
        super(key: key);
  final String hinttext;

  final Size size;
  final TextEditingController _email;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29.0),
      ),
      width: 300,
      child: TextFormField(
          cursorColor: Colors.purple[400],
          controller: _email,
          decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.purple[400],
            ),
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.white),
          )),
    );
  }
}
