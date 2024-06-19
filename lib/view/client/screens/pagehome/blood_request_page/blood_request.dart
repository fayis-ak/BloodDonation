import 'package:blood_donation/constants/firebase_const.dart';

import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/client/bottomnav.dart';
import 'package:blood_donation/view/client/screens/pagehome/hompage.dart';
import 'package:blood_donation/view/client/widgets/signup_button.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../../constants/color.dart';
import '../../../../widgets/custom form field.dart';
import '../../../widgets/text_form_field.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final agecontroller = TextEditingController();
  final bloodunitcontroller = TextEditingController();
  String? selectedgroup;
  late String dateSelected;
  bool _isRegistering = false;
  bool ispick = false;
  bool checkValue = false;
  final List<String> gender = ["Male", "Female", "Other"];
  final List<String> bloodgroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "RH+",
    "AB-",
    "RH-",
  ];

  String? selectedgender;
  Future _selectdate() async {
    ispick = true;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateSelected = picked.toString().split(" ")[0];
      });
    }
    debugPrint(dateSelected);
    return dateSelected;
  }

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    dateSelected = currentDate.toLocal().toIso8601String().split('T')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "BloodRequest",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .5,
                    child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv9uDdmjrFo6WmHa4Sel4yVIjUIw75aUvNPA&usqp=CAU'),
                  ),
                  TextFormFieldWidget(
                    label: "Patient Name",
                    icon: const Icon(Icons.person),
                    controller: nameController,
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
                  CustomFormField(
                    controller: phoneController,
                    textinputtype: TextInputType.number,
                    maxlength: 10,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    icons: Icon(Icons.phone),
                    labeltxt: "Contact number",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  CustomFormField(
                    labeltxt: "Hospital address",
                    maxline: 3,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormFieldWidget(
                            keyboardType: TextInputType.number,
                            label: "Age",
                            maxAgeLength: 3,
                            icon: const Icon(Icons.numbers),
                            controller: agecontroller,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
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
                        const SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(140, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: Colours.black,
                            side: const BorderSide(
                              color: Colours.lightRed,
                            ),
                          ),
                          onPressed: () {
                            _selectdate();
                          },
                          child: ispick
                              ? Text(dateSelected)
                              : const Text("Choose Date"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 5,
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
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormFieldWidget(
                              keyboardType: TextInputType.number,
                              label: "Blood Unit",
                              maxAgeLength: 2,
                              icon: const Icon(Icons.numbers),
                              controller: bloodunitcontroller,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CheckboxListTile(
                    title: const Text('Blood emergency'),
                    subtitle: const Text('are you sure argent blood '),
                    autofocus: false,
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    selected: checkValue,
                    value: checkValue,
                    onChanged: (value) {
                      setState(() {
                        checkValue = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isRegistering
                      ? CircularProgressIndicator()
                      : SignUpOrSignInButton(
                          buttonName: "Submit",
                          onPress: () {
                            if (!_isRegistering) {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                Blood_Request();
                                CustomToast.showSuccessToast(
                                    "Successfully Sumbit");
                              }
                            }
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

  Future<void> Blood_Request() async {
    try {
      setState(() {
        _isRegistering = true;
      });
      String uid = fire_auth.currentUser!.uid;
      String blood = selectedgroup.toString();
      String name = nameController.text;
      String phone = phoneController.text;
      String adress = addressController.text;
      String age = agecontroller.text;
      String date = dateSelected.toString();
      String gender = selectedgender.toString();
      String blooduint = bloodunitcontroller.text;
      bool emergency = checkValue;

      await FireService()
          .blood_request(blood, name, phone, adress, age, date, gender,
              blooduint, uid, emergency)
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Client_BottomNav(),
              )));
    } on FirebaseException catch (e) {
      print("enter the full details ");
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }
}
