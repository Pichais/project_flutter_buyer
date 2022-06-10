import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user-cart-item")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('item')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Card(
              elevation: 5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot _docSnap = snapshot.data!.docs[index];
                    return ListTile(
                      leading: Text(_docSnap['name']),
                      title: Text(_docSnap['price'].toString()),
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("user-cart-item")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('item')
                                .doc(_docSnap.id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
