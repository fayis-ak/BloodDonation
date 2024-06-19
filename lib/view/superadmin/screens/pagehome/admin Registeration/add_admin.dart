import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/const%20img.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/widgets/signup_button.dart';
import 'package:blood_donation/view/admin/widgets/text_form_field.dart';
import 'package:blood_donation/view/widgets/bottomsheet.dart';
import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:blood_donation/view/widgets/pickimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../sevice/user_Auth/auth_service.dart';
import '../../../../client/bottomnav.dart';
import '../../../bottomnav.dart';
import 'admin_home.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  File? _pickedImage;
  bool isLoading = false;
  final FireService _auth = FireService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colours.red,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: MediaQuery.of(context).size.height * .07,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : null),
                      Positioned(
                          top: MediaQuery.of(context).size.height * .09,
                          left: MediaQuery.of(context).size.height * .08,
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builderContext) {
                                      return BottomSheetModel(
                                        bottomsheetname: "profile photo",
                                        pickcamera: () async {
                                          final image = await ImagePickerHelperC
                                              .pickImageFromCamera();
                                          if (image != null) {
                                            setState(() {
                                              _pickedImage = File(image.path);
                                            });
                                          }
                                        },
                                        pickgallery: () async {
                                          final image1 =
                                              await ImagePickerHelperG
                                                  .pickImageFromGallery();
                                          if (image1 != null) {
                                            setState(() {
                                              _pickedImage = File(image1.path);
                                            });
                                          }
                                          ;
                                        },
                                        handeldelete: () {
                                          setState(() {
                                            _pickedImage = null;
                                          });
                                        },
                                      );
                                    });
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 208, 208, 208),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  CustomFormField(
                    controller: nameController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                    },
                    labeltxt: "Name",
                    icons: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CustomFormField(
                    controller: numberController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                    },
                    labeltxt: "phone number",
                    icons: Icon(Icons.phone),
                    textinputtype: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CustomFormField(
                    controller: emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail.com$")
                          .hasMatch(value)) {
                        return "please enter valid email";
                      }
                    },
                    labeltxt: "email",
                    icons: Icon(Icons.email),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CustomFormField(
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                    },
                    icons: Icon(Icons.lock),
                    labeltxt: "password",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CustomFormField(
                    validation: (value) {
                      if (passwordController.text != value) {
                        return "not match";
                      }
                    },
                    icons: Icon(Icons.lock),
                    labeltxt: "confirm password",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SignUpOrSignInButton(
                          buttonName: "Create",
                          onPress: () {
                            CustomToast.showSuccessToast("Successfully Add Admin");
                            admin_add();
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> admin_add() async {
    try {

      setState(() {
        isLoading = true;
      });
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = numberController.text.trim();
      String name = nameController.text.trim();

      if (formkey.currentState!.validate()) {
        await _auth
            .signUpWithEmailAndPassword(email, password, )
            .then((value) async {
          String userId = value!.uid;
          await FireService()
              .save_admin(name, email, phone, userId, _pickedImage)
              .then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminHome(),
                    ),
                    (route) => false,
                  ));
        });

        setState(() {
          _pickedImage = null;
          nameController.clear();
          numberController.clear();
          emailController.clear();
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
