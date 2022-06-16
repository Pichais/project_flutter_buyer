// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/page/product/category_product.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class categories extends StatelessWidget {
  const categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String Milk = 'Milk',
        Egg = 'Egg',
        Vegetable = "vegetable",
        AnimalFeed = 'AnimalFeed',
        Meat = 'Meat',
        Other = "other";
    return GridView(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: [
        Card(
          child: InkWell(
            onTap: () {
              print('Category');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: Milk,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image: DecorationImage(
                          image: AssetImage(Myconstant.catMilk),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Milk'),
              ],
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: Egg,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image:
                          DecorationImage(image: AssetImage(Myconstant.catEgg)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Eggs'),
              ],
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: Vegetable,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image:
                          DecorationImage(image: AssetImage(Myconstant.catVeg)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Oganic-Food'),
              ],
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: AnimalFeed,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image: DecorationImage(
                          image: AssetImage(Myconstant.catFeed)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Animal&Feed'),
              ],
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: Meat,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image: DecorationImage(
                          image: AssetImage(Myconstant.catMeat)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Meat'),
              ],
            ),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageCategory(
                            valueFromCate: Other,
                          )));
            },
            child: Column(
              children: [
                Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 185, 184, 184),
                      image: DecorationImage(
                          image: AssetImage(Myconstant.catOther)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10)),
                const Text('Other'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
