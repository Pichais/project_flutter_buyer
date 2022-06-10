import 'package:flutter/cupertino.dart';
import 'package:project_flutter_buyer/page/authen.dart';
import 'package:project_flutter_buyer/page/create_account.dart';
import 'package:project_flutter_buyer/page/main_screen.dart';
import 'package:project_flutter_buyer/page/product_detail.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/createAccount': (BuildContext context) => const Create(),
  '/mainscreen': (BuildContext context) => const MainScreen(),
  '/product_detail': (BuildContext context) => const ProductDetail(),
  // '/Category': (BuildContext context) => Category(),
};
