import 'package:flutter/material.dart';

class Myconstant {
  //Genernal
  static String appName = 'Fram Mart';

  //Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/register';
  static String routeMyservice = '/mainscreen';
  static String routeCategory = '/Category';
  static String routeCart = '/cart';

  //image
  static String shopwall = 'images/shoppingwall.jpg';
  static String image1 = 'images/image01.png';
  static String image2 = 'images/image02.png';
  static String image3 = 'images/image03.png';
  static String image4 = 'images/image04.png';
  static String avata = 'images/avata.png';
  static String photo = 'images/photo1.png';
  static String catMilk = 'images/milk.png';
  static String catEgg = 'images/eggs.png';
  static String catVeg = 'images/organic.png';
  static String catFeed = 'images/feed.png';
  static String catMeat = 'images/meat.png';
  static String catOther = 'images/farm.png';

  //color
  static Color primary = const Color(0xffffa600);
  static Color light = const Color(0xffffd74a);
  static Color dark = const Color(0xffc67700);

  //Style
  TextStyle h1style() =>
      TextStyle(fontSize: 24, color: dark, fontWeight: FontWeight.bold);

  TextStyle h2style() =>
      TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.w700);

  TextStyle h2styleTest(String string) =>
      TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.w700);

  TextStyle h3style() =>
      TextStyle(fontSize: 14, color: dark, fontWeight: FontWeight.normal);

  //ButtonStyle
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: Myconstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
  //Account

}
