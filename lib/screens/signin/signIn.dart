import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:se/main.dart';
import 'package:se/screens/signin/components/containertextemail.dart';
import 'package:se/screens/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:se/screens/signup.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignInForm());
  }
}

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  double _formProgress;

  void _updateformprogress() {
    var progress = 0.0;
    var controllers = [_email, _password];
    for (var i in controllers) {
      if (i.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
      setState(() {
        _formProgress = progress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print('hello');
    // print(sp.getString('email'));
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            child: Image(
              image: AssetImage("images/signup2.png"),
              // width: size.width,
              height: size.height,
              // fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 30,
            child: Form(
              onChanged: _updateformprogress,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Containertextfield(
                    color: Colors.purple[100],
                    hinttext: 'Email',
                    size: size,
                    email: _email,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius: BorderRadius.circular(29.0)),
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      cursorColor: Colors.purple[400],
                      controller: _password,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.purple[400],
                          ),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.purple[400],
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29.0),
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.purple[400]),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 24))),
                        onPressed: () async {
                          var response = await http.get(Uri.parse(
                              'http://127.0.0.1:5000/get?email=${_email.text}'));
                          List map = jsonDecode(response.body);

                          if (map.length > 0) if (map[0]['password'] ==
                              _password.text) {
                            setState(() {
                              sp.setBool('isloggedin', true);
                              sp.setString("name", map[0]['name']);
                              sp.setString('email', _email.text);
                            });
                            Navigator.pushReplacementNamed(context, "/user");
                          }
                          ;
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New user?',
                          style: TextStyle(color: Colors.purple[400]),
                        ),
                        SizedBox(
                          width: 03,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupApp()));
                          },
                          child: Text("Sign Up",
                              style: TextStyle(
                                color: Colors.purple[400],
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: 300,
                    child: Divider(
                      thickness: 0.5,
                      height: 5,
                      color: Colors.purple[200],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(width: 2, color: Colors.purple[100])),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Users()));
                        },
                        icon: Icon(Icons.home),
                        color: Colors.purple[400]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
