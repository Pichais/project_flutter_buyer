// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/order_model.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/utility/dialog.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

typedef StringCallback = void Function();

class ShowdetailProduct extends StatefulWidget {
  final StringCallback callback;
  final dynamic name, price, detail, image, docsID, stock;
  const ShowdetailProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.detail,
    required this.image,
    required this.docsID,
    required this.stock,
    required this.callback,
  }) : super(key: key);

  @override
  State<ShowdetailProduct> createState() => _ShowdetailProductState();
}

class _ShowdetailProductState extends State<ShowdetailProduct> {
  dynamic name, price, detail, image, docsID, stock;
  int amount = 0;

  @override
  void initState() {
    name = widget.name;
    price = widget.price;
    detail = widget.detail;
    image = widget.image;
    stock = widget.stock;
    docsID = widget.docsID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.fitHeight)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(15)),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "฿ ${price.toStringAsFixed(0)}.-",
                  style: TextStyle(fontSize: 20, color: Colors.amber[800]),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "รายละเอียด",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        detail,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(25)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Text('จำนวน'),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: 75,
                    height: 35,
                    child: Center(
                        child: Text(
                      amount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: IconButton(
                      onPressed: () {
                        removeProduct();
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.amber,
                        size: 35,
                      )),
                ),
                IconButton(
                    onPressed: () {
                      addProduct();
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.amber,
                      size: 35,
                    )),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 22),
              width: 160,
              child: ElevatedButton(
                style: Myconstant().myButtonStyle(),
                onPressed: () {
                  if (amount > 0) {
                    checkStockProduct(stock);
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void removeProduct() {
    if (amount > 0) {
      setState(() {
        amount--;
      });
    } else {
      amount = 0;
    }
  }

  void addProduct() {
    setState(() {
      amount++;
    });
  }

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");

    String generateRandomString(int len) {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      var r = Random();
      return String.fromCharCodes(List.generate(
          len, (index) => _chars.codeUnitAt(r.nextInt(_chars.length))));
    }

    var iditem = generateRandomString(20);

    print(_collectionRef.id);
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(iditem)
        .set({
      "name": name,
      "price": price,
      "detail": detail,
      "images": image,
      "amount": amount,
      "id": iditem,
      "idProduct": docsID,
    }).then((value) {
      print("Added to cart");
      setState(() {
        widget.callback();
      });
    });
  }

  checkStockProduct(stock) async {
    if (amount > stock) {
      print('สินค้ามีจำนวนไม่เพียงพอ');
      normalDialog(context, 'สินค้ามีจำนวนไม่เพียงพอ');
    } else {
      stock = int.parse(stock.toString()) - amount;
      print(amount);
      print(stock);
      print('ID Product $docsID');
      FirebaseFirestore.instance
          .collection('Product')
          .doc(docsID)
          .update({'Stock': stock});
      const snackBar = SnackBar(
          duration: Duration(seconds: 1), content: Text('Add to Cart Success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      addToCart();
    }
  }
}
