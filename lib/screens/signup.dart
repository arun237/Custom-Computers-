import 'package:flutter/material.dart';
import 'package:se/screens/signin/signIn.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class SignupApp extends StatelessWidget {
  const SignupApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[200], body: SignUpForm());
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _nameTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _mobileTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  double _formProgress = 0;
  int i = 0;
  List users = [];
  Map rows = {};
  Color a = Colors.green;
  Color b = Colors.blue;

  void onenter(PointerEnterEvent) {
    setState(() {
      a = Colors.greenAccent[700];
    });
  }

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _nameTextController,
      _emailTextController,
      _mobileTextController,
      _passwordTextController
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Form(
                onChanged: _updateFormProgress,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 05.00),
                    Text('Sign up',
                        style: Theme.of(context).textTheme.headline4),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _mobileTextController,
                        decoration: InputDecoration(
                          hintText: 'Mobile',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MouseRegion(
                        onEnter: (i) {
                          setState(() {
                            b = Colors.blueAccent[700];
                          });
                        },
                        onExit: (j) {
                          setState(() {
                            b = Colors.blue;
                          });
                        },
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return states.contains(MaterialState.disabled)
                                  ? null
                                  : Colors.white;
                            }),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return states.contains(MaterialState.disabled)
                                  ? null
                                  : b;
                            }),
                          ),
                          onPressed: () {
                            rows["firstname"] = _nameTextController.text;

                            rows['email'] = _emailTextController.text;

                            rows['mobile'] = _mobileTextController.text;
                            rows['password'] = _passwordTextController.text;
                            Map newMap = json.decode(json.encode(rows));

                            users.add(newMap);
                            i = i + 1;

                            post(Uri.parse(
                                "http://127.0.0.1:5000/post?name=${_nameTextController.text}&email=${_emailTextController.text}&mobile=${_mobileTextController.text}&password=${_passwordTextController.text}"));
                            _nameTextController.clear();

                            _emailTextController.clear();

                            _mobileTextController.clear();
                            _passwordTextController.clear();
                            print(users);
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MouseRegion(
                        onEnter: onenter,
                        onExit: (PointerEnterEvent) {
                          setState(() {
                            a = Colors.green;
                          });
                        },
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            }),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return a;
                            }),
                          ),
                          onPressed: () {
                            // _nameTextController.clear();

                            // _emailTextController.clear();

                            // _mobileTextController.clear();
                            // _passwordTextController.clear();
                            Navigator.pop(context);
                          },
                          child: Text('Sign In'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  AnimatedProgressIndicator({
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _curveAnimation;

  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    var colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value.withOpacity(0.4),
      ),
    );
  }
}
