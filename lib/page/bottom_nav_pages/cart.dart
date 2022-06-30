// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/order_model.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/page/payment/confirm_pay.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<OrderModel> orderModels = [];
  List<ProductModel> productModels = [];
  dynamic stock;
  late String docsID, idProduct;

  @override
  void initState() {
    readOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: orderModels.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(orderModels[index].image),
                          )),
                        ),
                        const Padding(padding: EdgeInsets.all(8)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(orderModels[index].name)),
                                  IconButton(
                                      onPressed: () {
                                        // addProduct();
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.amber,
                                        size: 20,
                                      )),
                                  Text(orderModels[index].amount.toString()),
                                  IconButton(
                                      onPressed: () {
                                        // addProduct();
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.amber,
                                        size: 20,
                                      )),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(8)),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      '฿ ${orderModels[index].price.toStringAsFixed(0)}.-',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.amber[800]),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: TextButton(
                                        onPressed: () {
                                          getStock(index);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 22),
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            style: Myconstant().myButtonStyle(),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConfirmPayment()));
            },
            child: const Text('Confirm'),
          ),
        ),
      ],
    ));
  }

  Future<void> readOrderData() async {
    if (orderModels != 0) {
      orderModels.clear();
    }

    await Firebase.initializeApp().then((value) async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-cart-items");
      _collectionRef
          .doc(currentUser!.email)
          .collection("items")
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          OrderModel orderModel = OrderModel.fromMap(snapshot.data());
          setState(() {
            docsID = snapshot.id;
            orderModels.add(orderModel);
          });
        }
      });
    });
  }

  getStock(int index) async {
    int sum = 0;
    var collection = FirebaseFirestore.instance.collection('Product');
    var docSnapshot = await collection.doc(orderModels[index].idProduct).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        stock = data['Stock'];
      });
      print(stock);
    }

    sum = stock + orderModels[index].amount;
    print(sum);
    FirebaseFirestore.instance
        .collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc(orderModels[index].id)
        .delete();

    FirebaseFirestore.instance
        .collection('Product')
        .doc(orderModels[index].idProduct)
        .update({'Stock': sum});

    setState(() {
      if (orderModels != 0) {
        orderModels.clear();
      }
    });
  }
}
