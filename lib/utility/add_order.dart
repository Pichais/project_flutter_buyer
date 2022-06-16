// ignore_for_file: avoid_print, prefer_collection_literals

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter_buyer/models/product_model.dart';

Future addToCart(List<ProductModel> products, int index, String email) async {
  Map<String, dynamic> map = Map();
  map['name'] = products[index].name;
  map['price'] = products[index].price;
  map['image'] = products[index].pathimage;
  map['detail'] = products[index].detail;

  await FirebaseFirestore.instance
      .collection('user-cart-item')
      .doc(email)
      .collection("item")
      .doc()
      .set(map)
      .then((value) => print('Add successful'));
}
