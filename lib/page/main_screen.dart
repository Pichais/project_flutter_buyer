import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/account_model.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/page/product_detail.dart';

import '../utility/my_constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<AccountModel> accounts = [];
  List<ProductModel> products = [];
  late String name, email, uid;
  int stock = 120, product = 0;

  @override
  void initState() {
    readAllData();
    super.initState();
  }

  Future<void> readAllData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('User')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          AccountModel account = AccountModel.fromMap(snapshot.data());
          setState(() {
            accounts.add(account);
          });
        }
      });
      await FirebaseFirestore.instance
          .collection('Product')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          ProductModel product = ProductModel.fromMap(snapshot.data());
          setState(() {
            products.add(product);
          });
        }
      });
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          setState(() {
            name = event.displayName!;
            email = event.email!;
            uid = event.uid;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hee'),
      ),
      body: Column(
        children: [
          Text(name),
          Text(email),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(products[index].pathimage)),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(18)),
                          Column(
                            children: [
                              Center(
                                  child: Text("Name ${products[index].name}")),
                              const Padding(padding: EdgeInsets.all(5)),
                              Center(
                                  child: Text(
                                      "Price ${products[index].price.toString()}")),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          reMoveToCart(products, index, email);
                                        });
                                      },
                                      icon: const Icon(Icons.remove_circle)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          addToCart(products, index, email);
                                        });
                                      },
                                      icon: const Icon(Icons.add_circle)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          const Padding(padding: EdgeInsets.all(18)),
          Center(
            child: TextButton(
              child: const Text(
                'Order Detail',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductDetail()),
                );
              },
            ),
          ),
          Center(
            child: TextButton(
              child: const Text(
                'Sing Out ',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, Myconstant.routeAuthen, (route) => false));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

Future reMoveToCart(
    List<ProductModel> products, int index, String email) async {
  // await FirebaseFirestore.instance
  //     .collection('user-cart-item')
  //     .doc(email)
  //     .collection("item")
  //     .doc()
  //     .set(map)
  //     .then((value) => print('Add successful'));
}
