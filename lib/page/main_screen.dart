import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/page/bottom_nav_pages/cart.dart';
import 'package:project_flutter_buyer/page/bottom_nav_pages/home.dart';
import 'package:project_flutter_buyer/page/bottom_nav_pages/profile.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [
    const Home(),
    const Cart(),
    const Profile(),
  ];
  var _currentIndex = 0;

  late String name, email, uid;
  int stock = 120, product = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome to SUT Farm Mart'),
        centerTitle: true,
        backgroundColor: Myconstant.primary,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Myconstant.primary,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
