import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/pickimage.dart';
import '../../../widgets/signup_button.dart';
import '../../../widgets/text_form_field.dart';

class AddHospitalDetails extends StatefulWidget {
  const AddHospitalDetails({super.key});

  @override
  State<AddHospitalDetails> createState() => _AddHospitalDetailsState();
}

class _AddHospitalDetailsState extends State<AddHospitalDetails> {
  final formkey = GlobalKey<FormState>();
  final hospitalname = TextEditingController();
  final hospitalnumber = TextEditingController();
  final hospitaldetailsandlocation = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colours.red,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.height * .08,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null),
                    Positioned(
                        top: MediaQuery.of(context).size.height * .11,
                        left: MediaQuery.of(context).size.height * .11,
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
                                        final image1 = await ImagePickerHelperG
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
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colours.lightRed,
                              size: MediaQuery.of(context).size.width * .07,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                CustomFormField(
                  labeltxt: "Hospital Name",
                  icons: Icon(Icons.local_hospital),
                  controller: hospitalname,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                CustomFormField(
                  labeltxt: "Hospital Number",
                  icons: Icon(Icons.phone),
                  controller: hospitalnumber,
                  textinputtype: TextInputType.number,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                  },
                ),
                //
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                CustomFormField(
                  controller: hospitaldetailsandlocation,
                  labeltxt: "Hospital details and locations",
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                  },
                  maxline: 5,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SignUpOrSignInButton(
                  buttonName: 'submit',
                  onPress: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      Hospitals_add();
                      CustomToast.showSuccessToast("Successfully Sumbit");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Hospitals_add() async {
    try {
      String name = hospitalname.text;
      String number = hospitalnumber.text;
      String details = hospitaldetailsandlocation.text;

      await FireService().hospital_add(name, number, details, _pickedImage);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print("enter the full details");
    }
  }
}
