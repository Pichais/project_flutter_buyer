import 'package:flutter/material.dart';

class PayCash extends StatefulWidget {
  const PayCash({Key? key}) : super(key: key);

  @override
  State<PayCash> createState() => _PayCashState();
}

class _PayCashState extends State<PayCash> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('PayCash'),
      ),
    );
  }
}
