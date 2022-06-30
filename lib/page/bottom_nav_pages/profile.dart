import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_buyer/models/account_model.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<AccountModel> userAccounts = [];
  String? name, email, dob;
  dynamic urlImage, phonenumber;
  @override
  void initState() {
    readDataUser();
    super.initState();
  }

  Future<void> readDataUser() async {
    Firebase.initializeApp().then((value) async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;

      FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser!.email)
          .snapshots()
          .forEach((element) {
        setState(() {
          name = element.data()!['name'];
          email = currentUser.email;
          urlImage = element.data()!['image'];
          phonenumber = element.data()!['phone'];
          dob = element.data()!['dob'];
        });
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
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage:
                    urlImage == null ? null : NetworkImage(urlImage),
              ),
            ),
            name == null ? const Text('1') : Text(name!),
            email == null ? const Text('1') : Text(email!),
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
