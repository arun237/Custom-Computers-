import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:se/main.dart';
import 'package:se/screens/coupon.dart';
import 'package:se/screens/order.dart';
import 'package:se/screens/signin/components/cartmodel.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff7fbfc),
      body: Consumer<CartModel>(
        builder: (context, cartmodel, child) {
          if (int.parse(cartmodel.cartTotal()) > 10000) {
            sp.setString('isfree', 'true');
          } else {
            sp.setString('isfree', 'false');
          }
          return cartmodel.lists.length != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: size.width / 2,
                      child: ListView.builder(
                          itemCount: cartmodel.lists.length,
                          itemBuilder: (context, i) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'images/peripherals/${cartmodel.lists[i]['type']}.png')),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xfff7fbfc),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartmodel.lists[i]['type'],
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.8)),
                                            ),
                                            // SizedBox(
                                            //   height: 3,
                                            // ),
                                            Text(
                                              cartmodel.lists[i]['name'],
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 15,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.8)),
                                            ),
                                            Container(
                                              // height: 50,
                                              // width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xfff7fbfc),
                                              ),
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text('Qty: 1'),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\u{20B9}${cartmodel.lists[i]['price']}',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      width: size.width / 2,
                                      child: Divider(
                                        thickness: 0.5,
                                        height: 5,
                                        color: Colors.blueGrey[100],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          200, 0, 0, 0),
                                      child: TextButton(
                                          onPressed: () {
                                            Provider.of<CartModel>(context,
                                                    listen: false)
                                                .remove(i);
                                          },
                                          child: Text('Remove')),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: size.width / 2.5,
                        height: size.height / 1.5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Order Details',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cart total',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Text(
                                      '\u{20B9}${cartmodel.cartTotal()}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cart Savings (10%)',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Text(
                                      '-${cartmodel.cartSavings().toString()}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Coupon Savings',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Coupon()));
                                      },
                                      child: sp.getString('coupon') == null
                                          ? Text(
                                              'Apply Coupon',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            )
                                          : Text(
                                              '-${CartModel.coupons[sp.getString('coupon')]}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Delivery',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    sp.getString('isfree') == 'true'
                                        ? Text(
                                            'Free',
                                            style: TextStyle(
                                                fontSize: 15,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          )
                                        : Text(
                                            '100',
                                            style: TextStyle(
                                                fontSize: 15,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Assemble fee',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Text(
                                      '2000',
                                      style: TextStyle(
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '\u{20B9}${cartmodel.totalAmount()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: size.width / 2,
                                  child: Divider(
                                    thickness: 0.5,
                                    height: 5,
                                    color: Colors.blueGrey[100],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\u{20B9}${cartmodel.totalAmount()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Container(
                                      // color: Colors.black,

                                      width: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.black)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Order()));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 20),
                                              child: Text(
                                                'Confirm Order',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart),
                      Text('Cart is Empty',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
