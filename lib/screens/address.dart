import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:se/main.dart';

class Address extends StatelessWidget {
  const Address({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Addressform(),
    );
  }
}

class Addressform extends StatefulWidget {
  Addressform({Key key}) : super(key: key);

  @override
  _AddressformState createState() => _AddressformState();
}

class _AddressformState extends State<Addressform> {
  Future<List> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetch();
  }

  Future<List> fetch() async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:5000/getAddress?email=${sp.getString('email')}"));
    return jsonDecode(response.body);
  }

  var _flatno = TextEditingController();
  var _street = TextEditingController();
  var _city = TextEditingController();

  var _pin = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();

  double _formProgress;

  void _updateformprogress() {
    double progress = 0.0;
    var controllers = [_flatno, _street, _city, _state, _district, _pin];
    for (var i in controllers) {
      if (i.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
      setState(() {
        _formProgress = progress;
        print(_formProgress);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List data = [];
    return Center(
      child: Row(
        children: [
          SizedBox(
            width: 400,
            child: Card(
              child: Form(
                onChanged: _updateformprogress,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedProgressIndicator(value: _formProgress),
                    Text(
                      "Address",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _flatno,
                        decoration: InputDecoration(hintText: 'Flat No'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _street,
                        decoration: InputDecoration(hintText: 'Street'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _city,
                        decoration: InputDecoration(hintText: 'city'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _district,
                        decoration: InputDecoration(hintText: 'District'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _state,
                        decoration: InputDecoration(hintText: 'State'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _pin,
                        decoration: InputDecoration(hintText: 'Pin Code'),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: _formProgress == 0.9999999999999999
                                    ? () async {
                                        print(sp.getString('email'));
                                        await http.post(Uri.parse(
                                            'http://127.0.0.1:5000/address?email=${sp.getString('email')}&flatno=${_flatno.text}&street=${_street.text}&city=${_city.text}&state=${_state.text}&district=${_district.text}&pin=${_pin.text}'));
                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Continue"),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                            (Set<MaterialState> states) =>
                                                states.contains(
                                                        MaterialState.disabled)
                                                    ? null
                                                    : Colors.white),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (Set<MaterialState> states) =>
                                                states.contains(
                                                        MaterialState.disabled)
                                                    ? null
                                                    : Colors.blue)),
                              ),
                            ])),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 200,
            child: FutureBuilder(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  sp.setString('address',
                                      'No.: ${data[i]['flatno']},${data[i]['street']},\n${data[i]['city']},${data[i]['district']},\n${data[i]['state']}-${data[i]['pin']}');
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Address ${i + 1}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Text(
                                            'No.: ${data[i]['flatno']},${data[i]['street']},\n${data[i]['city']},${data[i]['district']},\n${data[i]['state']}-${data[i]['pin']}',
                                            style:
                                                TextStyle(letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  }
                  return Center(child: const CircularProgressIndicator());
                }),
          )
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
