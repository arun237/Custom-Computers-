import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:se/screens/signin/components/cartmodel.dart';

class Products extends StatelessWidget {
  const Products({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebf1fa),
      body: BoardBody(),
    );
  }
}

class BoardBody extends StatefulWidget {
  BoardBody({Key key}) : super(key: key);

  @override
  _BoardBodyState createState() => _BoardBodyState();
}

class _BoardBodyState extends State<BoardBody> {
  Future<List> futureAlbum;

  // @override
  // void initState() {
  //   super.initState();
  //   futureAlbum = fetch();
  // }

  Future<List> fetch(String types) async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/product?name=$types"));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments as Map;
    String a = arg['type'];
    // print(a.toLowerCase());
    print(arg['type']);
    List data = [];
    print('hello');
    futureAlbum = fetch(arg['type']);
    return FutureBuilder(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            return GridView.count(
              // childAspectRatio: 1 / 1.5,
              crossAxisCount: 5,
              shrinkWrap: true,
              children: List.generate(
                  data.length,
                  (index) => Container(
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'images/peripherals/${arg['type']}.png')),
                                    color: Color(0xffebf1fa),
                                    borderRadius: BorderRadius.circular(10))),
                            SizedBox(height: 5),
                            Text(
                              data[index]['name'],
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\u{20B9}${data[index]['price']}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 160,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: TextButton(
                                    onPressed: () {
                                      Provider.of<CartModel>(context,
                                              listen: false)
                                          .addToCart(data[index]);
                                      Navigator.pop(context);
                                      // print(index);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.shopping_cart),
                                        SizedBox(width: 5),
                                        Text('Add to Cart')
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      )),
            );
          }
          return Center(child: const CircularProgressIndicator());
        });
  }
}
