import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsReg extends StatelessWidget {
  const ProductsReg({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: Products(),
          ),
        ),
      ),
    );
  }
}

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var _productid = TextEditingController();
  var _productname = TextEditingController();
  var _brand = TextEditingController();
  var _price = TextEditingController();

  double _formProgress;

  void _updateformprogress() {
    var progress = 0.0;
    var controllers = [_productid, _productname, _brand, _price];
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
    return Form(
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
              controller: _productid,
              decoration: InputDecoration(hintText: 'Product Id'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _productname,
              decoration: InputDecoration(hintText: 'Product Name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _brand,
              decoration: InputDecoration(hintText: 'Brand'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _price,
              decoration: InputDecoration(hintText: 'Price'),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: _formProgress == 1 ? () {} : null,
                      child: Text("Enter"),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  states.contains(MaterialState.disabled)
                                      ? null
                                      : Colors.white),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  states.contains(MaterialState.disabled)
                                      ? null
                                      : Colors.blue[900])),
                    ),
                  ])),
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
