import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se/main.dart';
import 'package:se/screens/cart.dart';
import 'package:se/screens/signin/components/cartmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coupon extends StatefulWidget {
  Coupon({Key key}) : super(key: key);

  @override
  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartModel>(
        builder: (context, cartmodel, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  width: 300,
                  child: ListView.builder(
                      itemCount: CartModel.coupons.length,
                      itemBuilder: (context, i) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                sp.setString('coupon',
                                    CartModel.coupons.keys.toList()[i]);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart()));
                              },
                              child: Text(
                                  '${CartModel.coupons.keys.toList()[i]}\n${CartModel.coupons.values.toList()[i]}',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    sp.remove('coupon');
                  });
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                child: Text(
                  'Remove Coupon',
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
