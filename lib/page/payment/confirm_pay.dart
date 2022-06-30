// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/order_model.dart';
import 'package:project_flutter_buyer/page/payment/paycash.dart';
import 'package:project_flutter_buyer/page/payment/transfer.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({Key? key}) : super(key: key);

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  List<OrderModel> orderModels = [];
  double allPrice = 0;

  @override
  void initState() {
    readOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: SafeArea(
              child: Center(
                child: Text(
                  'รายการทั้งหมด',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(flex: 3, child: Text('ชื่อสินค้า')),
              Expanded(flex: 2, child: Text('ราคา')),
              Expanded(flex: 1, child: Text('จำนวน')),
            ],
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
                itemCount: orderModels.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.all(15)),
                      Expanded(
                        flex: 3,
                        child: Text(orderModels[index].name),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(orderModels[index].price.toString())),
                      Expanded(
                          flex: 1,
                          child: Text(orderModels[index].amount.toString())),
                    ],
                  );
                }),
          ),
          Expanded(
              flex: 1,
              child: SizedBox(
                width: size.width,
                height: size.height / 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text('จำนวนรวม'),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: calculatePrice(orderModels)),
                    ],
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'ย้อนกลับ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PayCash()));
                  },
                  child: Text(
                    'จ่ายที่ร้าน',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transfer()));
                  },
                  child: Text(
                    'โอนจ่าย',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber[700],
                        fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
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
            orderModels.add(orderModel);
          });
        }
      });
    });
    calculatePrice(orderModels);
  }

  calculatePrice(List<OrderModel> orderModels) {
    double sum = 0.00;

    for (int i = 0; i < orderModels.length; i++) {
      allPrice = orderModels[i].amount * orderModels[i].price;
      sum = sum + allPrice;
    }
    return Text(sum.toString());
  }
}
