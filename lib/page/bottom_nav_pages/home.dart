// ignore_for_file: avoid_print, non_constant_identifier_names, await_only_futures

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/page/product/show_all_product.dart';

import 'package:project_flutter_buyer/utility/my_constant.dart';
import 'package:project_flutter_buyer/widgets/category_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> slideImage = [];
  var dotProsition = 0;

  @override
  void initState() {
    readImageData();
    super.initState();
  }

  readImageData() async {
    await Firebase.initializeApp().then((value) async {
      var _firestoreInstance = FirebaseFirestore.instance;
      QuerySnapshot qn =
          await _firestoreInstance.collection('carousel-slider').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          slideImage.add(qn.docs[i]['image-path']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          AspectRatio(
            aspectRatio: 3.5,
            child: CarouselSlider(
              items: slideImage
                  .map((item) => InkWell(
                        onTap: () {
                          print(dotProsition);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    item,
                                  ),
                                  fit: BoxFit.scaleDown)),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.8,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (val, carouselPageChangedReason) {
                  setState(() {
                    dotProsition = val;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          DotsIndicator(
            dotsCount: slideImage.isEmpty ? 1 : slideImage.length,
            position: dotProsition.toDouble(),
            decorator: DotsDecorator(
                activeColor: Myconstant.primary,
                activeSize: const Size(8, 8),
                size: const Size(6, 6),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
          const SizedBox(height: 10),
          Text(
            'CATEGORIES',
            style: TextStyle(fontSize: 17, color: Colors.orange[700]),
          ),
          const Expanded(
            flex: 2,
            child: categories(),
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowProduct()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Show All Products',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black26),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Myconstant.shopwall,
                          ),
                          fit: BoxFit.fitWidth)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
