// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:project_flutter_buyer/page/create_account/user_form.dart';
import 'package:project_flutter_buyer/page/login/login.dart';
import 'package:project_flutter_buyer/utility/dialog.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  signUp() async {
    Navigator.push(
        context, CupertinoPageRoute(builder: (_) => const UserForm()));
    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(
    //           email: _emailController.text, password: _passwordController.text);
    //   var authCredential = userCredential.user;
    //   print(authCredential!.uid);
    //   if (authCredential.uid.isNotEmpty) {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (_) => const UserForm()));
    //   } else {
    //     Fluttertoast.showToast(msg: "Something is wrong");
    //   }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     Fluttertoast.showToast(msg: "The password provided is too weak.");
    //   } else if (e.code == 'email-already-in-use') {
    //     Fluttertoast.showToast(
    //         msg: "The account already exists for that email.");
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Myconstant.primary,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: _width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.light,
                          color: Colors.transparent,
                        ),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: _width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Farm Mart SUT",
                            style: TextStyle(fontSize: 22),
                          ),
                          const Text(
                            "Welcome to create your account.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 41,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "EX: thed9954@gmail.com",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 134, 134, 134),
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 41,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: "password must be 6 character",
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 134, 134, 134),
                                    ),
                                    labelText: 'PASSWORD',
                                    labelStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange,
                                    ),
                                    suffixIcon: _obscureText == true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = false;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = true;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.visibility_off,
                                              size: 20,
                                            )),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                          // elevated button
                          SizedBox(
                            width: _width,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  normalDialog(
                                      context, 'Unsuccess ! please Try again');
                                } else {
                                  signUp();
                                }
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: Myconstant().myButtonStyle(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            children: [
                              const Text(
                                "Return to Login =>",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBBBBBB),
                                ),
                              ),
                              GestureDetector(
                                child: const Text(
                                  " Sign In",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => const Login()));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
