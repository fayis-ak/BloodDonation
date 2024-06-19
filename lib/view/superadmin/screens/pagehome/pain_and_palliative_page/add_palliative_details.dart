import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/pain_and_palliative_page/pain_and_palliative.dart';
import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../admin/screens/pagehome/pain_and_palliative_page/pain_and_palliative.dart';
import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/pickimage.dart';
import '../../../widgets/signup_button.dart';
import '../../../widgets/text_form_field.dart';

class AddPalliativeDetails_super extends StatefulWidget {
  const AddPalliativeDetails_super({super.key});

  @override
  State<AddPalliativeDetails_super> createState() =>
      _AddPalliativeDetails_superState();
}

class _AddPalliativeDetails_superState
    extends State<AddPalliativeDetails_super> {
  final formkey = GlobalKey<FormState>();
  final palliativename = TextEditingController();
  final palliativenumber = TextEditingController();
  final palliativelocation = TextEditingController();
  File? _pickedImage;
  bool ischecker = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Add Details",
          style: TextStyle(color: Colors.white),
        ),
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
                        radius: MediaQuery.of(context).size.height * .09,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null),
                    Positioned(
                        top: MediaQuery.of(context).size.height * .12,
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
                                        Navigator.pop(context);
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
                                        Navigator.pop(context);
                                      },
                                      handeldelete: () {
                                        setState(() {
                                          _pickedImage = null;
                                        });
                                        Navigator.pop(context);
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
                  height: MediaQuery.of(context).size.height * .02,
                ),
                CustomFormField(
                  controller: palliativename,
                  icons: Icon(Icons.person),
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                  },
                  labeltxt: "palliativename",
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                CustomFormField(
                  icons: Icon(Icons.phone),
                  labeltxt: "Palliative Number",
                  controller: palliativenumber,
                  textinputtype: TextInputType.number,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                CustomFormField(
                  controller: palliativelocation,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                  },
                  labeltxt: "Palliative details and locations",
                  maxline: 5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                ischecker
                    ? CircularProgressIndicator()
                    : SignUpOrSignInButton(
                        buttonName: 'submit',
                        onPress: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            painandaplivtive();
                            CustomToast.showSuccessToast("Successfully Submit");
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

  Future<void> painandaplivtive() async {
    try {
      setState(() {
        ischecker = true;
      });
      String name = palliativename.text;
      String number = palliativenumber.text;
      String location = palliativelocation.text;

      await FireService()
          .palliative(name, number, location, _pickedImage)
          .then((value) => Navigator.pop(context));
    } catch (e) {
    } finally {
      setState(() {
        ischecker = false;
      });
    }
  }
}
