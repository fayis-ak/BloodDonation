import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/admin/widgets/text_form_field.dart';
import 'package:blood_donation/view/widgets/bottomsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../sevice/user_Auth/auth_service.dart';
import '../../../../widgets/custom form field.dart';
import '../../../../widgets/pickimage.dart';
import '../../../widgets/signup_button.dart';
import 'dart:io';

class Super_addNssActivities extends StatefulWidget {
  const Super_addNssActivities({super.key});

  @override
  State<Super_addNssActivities> createState() => _Super_addNssActivitiesState();
}

class _Super_addNssActivitiesState extends State<Super_addNssActivities> {
  final _formkey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final discreptioncontroller = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.red,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        CustomFormField(
                          labeltxt: "Title",
                          controller: titlecontroller,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                          },
                          icons: Icon(Icons.label),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        CustomFormField(
                          labeltxt: "discreptions",
                          controller: discreptioncontroller,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                          },
                          icons: Icon(Icons.keyboard),
                          maxline: 5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .3,
                                child: _pickedImage != null
                                    ? Image.file(_pickedImage!)
                                    : null,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        SignUpOrSignInButton(
                            buttonName: "Attach Image",
                            onPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext buildcontext) {
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
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        SignUpOrSignInButton(
                            buttonName: "submit", onPress: () {Nss_events();}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Nss_events() async {
    try {
      String title = titlecontroller.text;
      String discreption = discreptioncontroller.text;

      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        // Navigator.pop(context);
      }
      await FireService().nss_events(title, discreption, _pickedImage);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print("enter the full details");
    }
  }
}
