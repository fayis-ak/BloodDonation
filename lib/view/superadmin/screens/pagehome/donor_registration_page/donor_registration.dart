import 'dart:io';

import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants/color.dart';
import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/custom form field.dart';
import '../../../../widgets/pickimage.dart';
import '../../../bottomnav.dart';
import '../../../widgets/signup_button.dart';
import '../../../widgets/text_form_field.dart';
import '../hompage.dart';

class Super_DonorRegistrationHome extends StatefulWidget {
  const Super_DonorRegistrationHome({super.key});

  @override
  State<Super_DonorRegistrationHome> createState() =>
      _Super_DonorRegistrationHomeState();
}

class _Super_DonorRegistrationHomeState
    extends State<Super_DonorRegistrationHome> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final addressController = TextEditingController();
  final weightController = TextEditingController();
  final agecontroller = TextEditingController();

  final List<String> bloodgroups = [
    "A+",
    "B+",
    "AB+",
    "RH+",
    "O+",
    "A-",
    "AB-",
    "RH-",
    "B-",
    "O-",
  ];
  final List<String> gender = ["Male", "Female", "Other"];

  String? selectedgroup;
  String? selectedgender;
  File? _pickedimage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .030,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * .06,
                      backgroundImage: _pickedimage != null
                          ? FileImage(_pickedimage!)
                          : null,
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * .08,
                        left: MediaQuery.of(context).size.height * .070,
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
                                            _pickedimage = File(image.path);
                                          });
                                        }
                                      },
                                      pickgallery: () async {
                                        final image1 = await ImagePickerHelperG
                                            .pickImageFromGallery();
                                        if (image1 != null) {
                                          setState(() {
                                            _pickedimage = File(image1.path);
                                          });
                                        }
                                        ;
                                      },
                                      handeldelete: () {
                                        setState(() {
                                          _pickedimage = null;
                                        });
                                      },
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colours.lightRed,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .020,
                ),
                CustomFormField(
                  labeltxt: "Name",
                  icons: const Icon(Icons.person),
                  controller: nameController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "Required Field";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomFormField(
                  labeltxt: "Email",
                  icons: const Icon(Icons.email_outlined),
                  controller: emailController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "Required Field";
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail.com$")
                        .hasMatch(value)) {
                      return "please enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomFormField(
                  textinputtype: TextInputType.number,
                  labeltxt: "Phone Number",
                  icons: const Icon(Icons.phone),
                  controller: phoneController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "Required Field";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: CustomFormField(
                          textinputtype: TextInputType.number,
                          labeltxt: "Age",
                          icons: Icon(Icons.numbers),
                          controller: agecontroller,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.0),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colours.lightRed)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colours.lightRed)),
                            prefixIcon: Icon(
                              Icons.bloodtype_outlined,
                              color: Colours.red,
                            ),
                            border: InputBorder.none,
                            hintText: "Blood Type",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          items: bloodgroups
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          value: selectedgroup,
                          onChanged: (value) {
                            setState(() {
                              selectedgroup = value as String?;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: CustomFormField(
                          textinputtype: TextInputType.number,
                          labeltxt: "Weight",
                          icons: Icon(Icons.numbers),
                          controller: weightController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.0),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colours.lightRed)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colours.lightRed)),
                            prefixIcon: Icon(
                              Icons.man_outlined,
                              color: Colours.red,
                            ),
                            border: InputBorder.none,
                            hintText: "Gender",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          items: gender
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          value: selectedgender,
                          onChanged: (value) {
                            setState(() {
                              selectedgender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomFormField(
                  labeltxt: "Address",
                  maxline: 5,
                  controller: addressController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const SizedBox(
                  height: 30,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : SignUpOrSignInButton(
                        buttonName: 'Register',
                        onPress: () {
                          if (_formkey.currentState!.validate()) {
                            add_Donor();
                            _formkey.currentState!.save();
                          }
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> add_Donor() async {
    try {
      String uid = fire_auth.currentUser!.uid;
      String name = nameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String age = agecontroller.text;
      String? blood = selectedgroup;
      String weight = weightController.text;
      String? gender = selectedgender;
      String adress = addressController.text;
      setState(() {
        _isLoading = true;
      });
      await FireService()
          .donorregistration(name, email, phone, age, blood!, weight, adress,
              _pickedimage, gender!, uid)
          .then(
              (value) => CustomToast.showSuccessToast("Successfully Register"))
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SuperAdminBottomNav(),
              ),
              (route) => false));
    } catch (e) {
      print("superrr addd_Doonor errrrrorr${e}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
