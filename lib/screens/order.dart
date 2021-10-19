import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:se/main.dart';
import 'package:se/screens/coupon.dart';
import 'package:se/screens/placed.dart';
import 'package:se/screens/signin/components/cartmodel.dart';
import 'package:http/http.dart' as http;
import 'package:se/screens/signin/components/ordersmodel.dart';

class Order extends StatelessWidget {
  const Order({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderBody(),
      backgroundColor: Color(0xfff7fbfc),
    );
  }
}

class OrderBody extends StatefulWidget {
  OrderBody({Key key}) : super(key: key);

  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<CartModel>(builder: (context, cartmodel, i) {
      if (int.parse(cartmodel.cartTotal()) > 10000) {
        sp.setString('isfree', 'true');
      } else {
        sp.setString('isfree', 'false');
      }
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Confirmation',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: sp.getString('address') != null
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home Delivery',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(sp.getString('name'),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 2,
                              ),
                              Text(sp.getString('address'),
                                  style: TextStyle(letterSpacing: 0.5)),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home Delivery',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text("You haven't selected your address yet"),
                            ],
                          ),
                        ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: ListView.builder(
                        itemCount: cartmodel.lists.length,
                        itemBuilder: (context, i) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/peripherals/${cartmodel.lists[i]['type']}.png')),
                                      borderRadius: BorderRadius.circular(10),
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
                                            decoration: TextDecoration.none,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                      // SizedBox(
                                      //   height: 3,
                                      // ),
                                      Text(
                                        cartmodel.lists[i]['name'],
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.8)),
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
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('Qty: 1'),
                                        )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '\u{20B9}${cartmodel.lists[i]['price']}',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: size.width / 2.5,
                height: size.height / 1.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart total',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Text(
                              '\u{20B9}${cartmodel.cartTotal()}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart Savings',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Text(
                              '-${cartmodel.cartSavings().toString()}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupon Savings',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Coupon()));
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Assemble fee',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.black)),
                                    onPressed: () async {
                                      List _productid = List.generate(
                                          cartmodel.lists.length,
                                          (index) => cartmodel.lists[index]
                                              ['product_id']);
                                      String a = jsonEncode(_productid);
                                      var response = await http.get(Uri.parse(
                                          "http://127.0.0.1:5000/order?email=${sp.getString('email')}&productid=$a"));
                                      OrderModel.savings =
                                          cartmodel.cartSavings();
                                      OrderModel.total =
                                          cartmodel.totalAmount();
                                      OrderModel.totalcart =
                                          int.parse(cartmodel.cartTotal());

                                      cartmodel.removeAll();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Placed()));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: Text(
                                        'Place Order',
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
        ),
      );
    });
  }
}
