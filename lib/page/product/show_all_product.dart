// ignore_for_file: unrelated_type_equality_checks, await_only_futures, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/page/product/show_detail_product/show_detail_product.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  List<ProductModel> productModels = [];

  @override
  void initState() {
    readAllData();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
        centerTitle: true,
        backgroundColor: Myconstant.primary,
      ),
      body: ListView.builder(
          itemCount: productModels.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowdetailProduct()));
                },
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(productModels[index].pathimage),
                      )),
                    ),
                    const Padding(padding: EdgeInsets.all(22)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.all(10)),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("${productModels[index].name}"),
                          ),
                          const Padding(padding: EdgeInsets.all(6)),
                          Text(productModels[index].detail,
                              style: const TextStyle(
                                  color: Color.fromARGB(162, 117, 117, 117)),
                              overflow: TextOverflow.ellipsis),
                          const Padding(padding: EdgeInsets.all(4)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '฿ ${productModels[index].price.toStringAsFixed(2)}.-',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.amber[800]),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowdetailProduct()));
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline_outlined,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
