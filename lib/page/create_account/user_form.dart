// ignore_for_file: non_constant_identifier_names, prefer_final_fields, empty_catches, avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter_buyer/page/main_screen.dart';
import 'package:project_flutter_buyer/utility/dialog.dart';
import 'package:project_flutter_buyer/utility/my_constant.dart';
import 'package:project_flutter_buyer/utility/show_image.dart';
import 'package:project_flutter_buyer/utility/show_title.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _dobController = TextEditingController();
  File? file;
  dynamic gender, urlPicture;
  late String name, phonnumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Submit the form to continue.",
                      style: TextStyle(fontSize: 22, color: Myconstant.primary),
                    ),
                    const Text(
                      "We will not share your information with anyone.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFBBBBBB),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => chooseImage(ImageSource.camera),
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 36,
                            color: Myconstant.dark,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          width: 150,
                          child: file == null
                              ? ShowImage(pathImage: Myconstant.avata)
                              : Image.file(file!),
                        ),
                        IconButton(
                          onPressed: () => chooseImage(ImageSource.gallery),
                          icon: Icon(
                            Icons.add_photo_alternate,
                            size: 36,
                            color: Myconstant.dark,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Text('Information : ',
                        style: TextStyle(color: Myconstant.primary)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            onChanged: (value) => name = value.trim(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'กรุณาระบุ Name ของคุณ';
                              } else {}
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: Myconstant().h3style(),
                              labelText: 'Name ',
                              prefixIcon: Icon(
                                Icons.face,
                                color: Myconstant.dark,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Myconstant.dark),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Myconstant.light),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            onChanged: (value) => phonnumber = value.trim(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'กรุณากรอกหมายเลขโทรศัพท์ ของคุณ';
                              } else {}
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: Myconstant().h3style(),
                              labelText: 'Phone Number ',
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Myconstant.dark,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Myconstant.dark),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Myconstant.light),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Text(
                      'date of birth',
                      style: TextStyle(color: Myconstant.primary),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "date of birth",
                            suffixIcon: IconButton(
                              onPressed: () => _selectDateFromPicker(context),
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Myconstant.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Text('Choose your gender : ',
                        style: TextStyle(color: Myconstant.primary)),
                    Choose_Gender(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 22),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            style: Myconstant().myButtonStyle(),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                sendUserDataToDB();
                              } else {
                                normalDialog(
                                    context, 'กรุณากรอกข้อมูลของคุณให้ครบ');
                              }
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Choose_Gender() {
    return Column(
      children: [
        RadioListTile(
          value: 'Male',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
          title: ShowTitle(
            title: 'ผู้ชาย (Male)',
            textStyle: Myconstant().h3style(),
          ),
        ),
        RadioListTile(
          value: 'Female',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
          title: ShowTitle(
            title: 'ผู้หญิง (Female)',
            textStyle: Myconstant().h3style(),
          ),
        ),
        RadioListTile(
          value: 'Other',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
          title: ShowTitle(
            title: 'อื่นๆ (Other)',
            textStyle: Myconstant().h3style(),
          ),
        ),
      ],
    );
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      // ignore: deprecated_member_use
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    Random random = Random();
    int i = random.nextInt(10000);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference = firebaseStorage.ref().child('User/user$i.png');
    UploadTask storageUploadTask = storageReference.putFile(file!);

    await storageUploadTask.whenComplete(() async {
      urlPicture = await storageUploadTask.snapshot.ref.getDownloadURL();
    });
    print('URL is = $urlPicture');

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("User");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": name,
          "phone": phonnumber,
          "dob": _dobController.text,
          "gender": gender,
          "image": urlPicture,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MainScreen())))
        .catchError((error) => print("something is wrong. $error"));
  }
}
