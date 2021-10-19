import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:se/main.dart';

class OrderModel extends ChangeNotifier {
  static List<Map> _orders = [];
  static int savings = 0;
  static int totalcart = 0;
  static int total = 0;

  UnmodifiableListView<Map> get lists => UnmodifiableListView(_orders);
  // get coupons => _coupons;
  addToCart(List m) {
    _orders = m;
    notifyListeners();
  }

  static void removeAll() {
    _orders.clear();
    // This call tells the widgets that are listening to this model to rebuild.
  }
}
