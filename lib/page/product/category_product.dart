// ignore_for_file: avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/page/product/show_detail_product/show_detail_product.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class PageCategory extends StatefulWidget {
  final String valueFromCate;
  const PageCategory({Key? key, required this.valueFromCate}) : super(key: key);

  @override
  State<PageCategory> createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  List<ProductModel> productModels = [];
  String nameCate = '';
  int amounts = 0;

  @override
  void initState() {
    nameCate = widget.valueFromCate.toString();

    readAllData(nameCate);
    super.initState();
  }

  Future<void> readAllData(String nameCate) async {
    if (productModels != 0) {
      productModels.clear();
    }
    await Firebase.initializeApp().then((value) async {
      print('**initialize Success***');
      await FirebaseFirestore.instance
          .collection('Product')
          .where("Type", isEqualTo: nameCate)
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print(map);
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
        backgroundColor: Myconstant.primary,
        title: Text(nameCate),
      ),
      body: ListView.builder(
          itemCount: productModels.length,
          itemBuilder: (context, index) {
            dynamic name, price, image, detail, stock, idproduct;
            idproduct = productModels[index].id;
            name = productModels[index].name;
            price = productModels[index].price;
            image = productModels[index].pathimage;
            detail = productModels[index].detail;
            stock = productModels[index].stock;
            if (productModels.isNotEmpty) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowdetailProduct(
                                  name: name,
                                  price: price,
                                  detail: detail,
                                  image: image,
                                  docsID: idproduct,
                                  stock: stock,
                                  callback: () {
                                    readAllData(nameCate);
                                  },
                                )));
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
                                                  ShowdetailProduct(
                                                    name: name,
                                                    price: price,
                                                    detail: detail,
                                                    image: image,
                                                    docsID: idproduct,
                                                    stock: stock,
                                                    callback: () {
                                                      readAllData(nameCate);
                                                    },
                                                  )));
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
            } else {
              return const SafeArea(child: Text('No datat'));
            }
          }),
    );
  }
}
