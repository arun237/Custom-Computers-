import 'package:http/http.dart' as http;
import 'dart:convert';

class A {
  List a = [
    {'a': 1}
  ];
  add(Map val) {
    a.add(val);
  }
}

// fetch() async {

//   return lists;
// }

main(List<String> args) async {
  var response = await http.get(Uri.parse('http://127.0.0.1:5000/product'));
  List lists = json.decode(response.body);
  A a = A();
  a.add({'b': 2});
  print(a.a);
  print(lists[0]);
}
