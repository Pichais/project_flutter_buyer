// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/product_model.dart';

class ShowdetailProduct extends StatefulWidget {
  const ShowdetailProduct({Key? key}) : super(key: key);

  @override
  State<ShowdetailProduct> createState() => _ShowdetailProductState();
}

class _ShowdetailProductState extends State<ShowdetailProduct> {
  List<ProductModel> productModels = [];
  int index = 0;

  @override
  void initState() {
    readAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Card(
              child: Container(
                child: const Center(
                  child: Text('Image'),
                ),
                width: MediaQuery.of(context).size.width,
                height: 250,
                color: Colors.grey,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(productModels[index].pathimage),
                //         fit: BoxFit.contain)),
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
      )),
    );
  }

  Future<void> readAllData() async {
    if (productModels != 0) {
      productModels.clear();
    }
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('Product')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          ProductModel productModel = ProductModel.fromMap(snapshot.data());
          setState(() {
            productModels.add(productModel);
          });
        }
      });
    });
  }
}
