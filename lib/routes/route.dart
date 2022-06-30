import 'package:flutter/cupertino.dart';
import 'package:project_flutter_buyer/page/bottom_nav_pages/cart.dart';
import 'package:project_flutter_buyer/page/login/login.dart';
import 'package:project_flutter_buyer/page/create_account/register_screen.dart';
import 'package:project_flutter_buyer/page/main_screen.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Login(),
  '/register': (BuildContext context) => const RegistrationScreen(),
  '/mainscreen': (BuildContext context) => const MainScreen(),
  // '/product_detail': (BuildContext context) => const ProductDetail(),
  '/cart': (BuildContext context) => const Cart(),
  // '/Category': (BuildContext context) => Category(),
};
