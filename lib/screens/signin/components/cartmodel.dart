import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:se/main.dart';

class CartModel extends ChangeNotifier {
  static Map coupons = {'first': 500, 'super50': 50, 'Aug100': 100};
  List<Map> _lists = [];
  UnmodifiableListView<Map> get lists => UnmodifiableListView(_lists);
  // get coupons => _coupons;
  addToCart(Map m) {
    _lists.add(m);
    notifyListeners();
  }

  String cartTotal() {
    int total = 0;
    for (int i = 0; i < _lists.length; i++) {
      total += int.parse(_lists[i]['price']);
    }

    return total.toString();
  }

  remove(int index) {
    _lists.removeAt(index);
    notifyListeners();
  }

  cartSavings() {
    return (10 * int.parse(cartTotal()) / 100);
  }

  totalSavings() {
    int savings = 0;
    if (sp.getString('isfree') == 'true') {
      if (sp.getString('coupon') != null)
        savings = cartSavings() + coupons[sp.getString('coupon')];
      else
        savings = cartSavings();
    } else {
      if (sp.getString('coupon') != null)
        savings = (cartSavings() + coupons[sp.getString('coupon')]) - 100;
      else
        savings = (cartSavings()) - 100;
    }
    return savings;
  }

  totalAmount() {
    return int.parse(cartTotal()) - totalSavings() + 2000;
  }

  void removeAll() {
    _lists.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
