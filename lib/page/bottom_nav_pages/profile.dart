import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/account_model.dart';
import 'package:project_flutter_buyer/models/product_model.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<AccountModel> userAccounts = [];
  String? name, email;
  dynamic urlImage;
  @override
  void initState() {
    readDataUser();
    super.initState();
  }

  Future<void> readDataUser() async {
    Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName!;
          email = event.email!;
        });
      });
      await FirebaseFirestore.instance
          .collection('User')
          .snapshots()
          .listen((event) {
            for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          AccountModel userAccount = AccountModel.fromMap(snapshot.data());
          setState(() {
            userAccounts.add(userAccount);
          });
        }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(),
            // ),
            name == null ? const Text('') : Text(name!),
            email == null ? const Text('') : Text(email!),
            TextButton(
              onPressed: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, Myconstant.routeAuthen, (route) => false));
                });
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
