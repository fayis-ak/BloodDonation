import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/admin/widgets/text_form_field.dart';
import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:permission_handler/permission_handler.dart';
import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/pickimage.dart';
import '../../../widgets/signup_button.dart';

class AddAmbulanceService extends StatefulWidget {
  const AddAmbulanceService({super.key});

  @override
  State<AddAmbulanceService> createState() => _AddAmbulanceServiceState();
}

class _AddAmbulanceServiceState extends State<AddAmbulanceService> {
  final formkey = GlobalKey<FormState>();
  final drivername = TextEditingController();
  final drivernumber = TextEditingController();
  final vehicledetailsandlocation = TextEditingController();
  File? _pickedImage;
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Center(child: Text("Add Ambulance Service")),
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
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomFormField(
                  labeltxt: "Driver Name",
                  icons: Icon(Icons.person),
                  controller: drivername,
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
                  controller: drivernumber,
                  textinputtype: TextInputType.number,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                  },
                  icons: Icon(Icons.phone),
                  labeltxt: "Driver number",
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                CustomFormField(
                  controller: vehicledetailsandlocation,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                  },
                  maxline: 5,
                  labeltxt: "vehicle details and locations",
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                _isRegistering
                    ? const Center(child: CircularProgressIndicator())
                    : SignUpOrSignInButton(
                        buttonName: 'submit',
                        onPress: () {
                          if (!_isRegistering) {

                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();
                              aadd();
                            }
                          }
                        },

                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> aadd() async {
    try {
      setState(() {
        _isRegistering = true;
      });
      String name = drivername.text;
      String number = drivernumber.text;
      String location = vehicledetailsandlocation.text;


      await FireService().ambulance_serbi(name, number, location, _pickedImage).then((value) =>Navigator.pop(context) );

      setState(() {
        _pickedImage = null;
        drivername.clear();
        drivernumber.clear();
        vehicledetailsandlocation.clear();
      });
    } catch (e) {
      print('Error uploading image: $e');
      print("Something went wrong...");
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }

}
