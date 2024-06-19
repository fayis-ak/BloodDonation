import 'dart:io';

import 'package:blood_donation/view/client/widgets/signup_button.dart';
import 'package:blood_donation/view/client/widgets/text_form_field.dart';
import 'package:blood_donation/view/widgets/loading_button_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/color.dart';
import '../../sevice/user_Auth/auth_service.dart';
import '../client/bottomnav.dart';
import '../widgets/bottomsheet.dart';
import '../widgets/pickimage.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool _obsucreText = true;

  void toggle() {
    setState(() {
      _obsucreText = !_obsucreText;
    });
  }

  bool isLoading = false;
  final FireService _auth = FireService();
  int agedata = 3;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // final bloodGroupController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final agecontroller = TextEditingController();

  late String dateSelected;
  bool ispick = false;
  bool isSigningUp = false;
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
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    dateSelected = currentDate.toLocal().toIso8601String().split('T')[0];
  }

  final _formKey = GlobalKey<FormState>();
  String selectedValue = "A+";
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const AssetImage(
                              'assets/imagepicker/unnamed.png',
                            ) as ImageProvider<Object>,
                      radius: 70,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            const Color.fromARGB(255, 173, 167, 167),
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
                                          _imageFile = File(image.path);
                                        });
                                      }
                                    },
                                    pickgallery: () async {
                                      final image1 = await ImagePickerHelperG
                                          .pickImageFromGallery();
                                      if (image1 != null) {
                                        setState(() {
                                          _imageFile = File(image1.path);
                                        });
                                      }
                                      
                                    },
                                    handeldelete: () {
                                      setState(() {
                                        _imageFile = null;
                                      });
                                    },
                                  );
                                });
                          },
                          icon: const Icon(Icons.camera_alt_outlined,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  TextFormFieldWidget(
                      label: "Name",
                      icon: const Icon(Icons.person),
                      controller: usernameController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "Required Field";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  TextFormFieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      icon: const Icon(Icons.email_outlined),
                      controller: emailController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                        final emailRegex =
                            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  TextFormFieldWidget(
                      keyboardType: TextInputType.phone,
                      label: "Phone Number",
                      maxAgeLength: 10,
                      icon: const Icon(Icons.phone),
                      controller: phoneController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter number';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: TextFormFieldWidget(
                              keyboardType: TextInputType.number,
                              label: "Age",
                              
                              controller: agecontroller,
                              maxAgeLength: 3,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your age';
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.0,
                          child: DropdownButtonFormField(
                            value: selectedValue,
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
                            ),
                            items: bloodgroups
                                .map((String e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
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
                              : const Text("Date of birth"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  TextFormFieldWidget(
                      label: "Address",
                      icon: const Icon(Icons.home_outlined),
                      controller: addressController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'is requred';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  TextFormFieldWidget(
                      label: "Password",
                      icon: const Icon(Icons.key_outlined),
                      controller: passwordController,
                      suffixIconButton: IconButton(
                          onPressed: () {
                            toggle();
                          },
                          icon: Icon(_obsucreText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      obscuretextd: _obsucreText,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'enter password ';
                        } else if (value.length < 8) {
                          return 'Password mustbe at 8 ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  TextFormFieldWidget(
                      label: "Confirm-Password",
                      icon: const Icon(Icons.key_outlined),
                      obscuretextd: true,
                      controller: confirmPasswordController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'password is required';
                        } else if (value != passwordController.text) {
                          return 'password do not match';
                        }
                        return null;
                      }
                      ),
                  const SizedBox(
                    height: 30,
                  ),
                  // isLoading
                  //     ? const Center(child: CircularProgressIndicator())
                  //     : SignUpOrSignInButton(
                  //         buttonName: 'Register',
                  //         onPress: () {
                  //           if (!isLoading) {
                  //             _signUp();
                  //           }
                  //         }),
                  SignUpOrSignInButtonClient(
                    buttonName: "Register",
                    onPress: () {
                      if (!isLoading) {
                        _signUp();
                      }
                    },
                    isLoading: isLoading,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  // Future<void> _signUp() async {
  //   try {
  //     String email = emailController.text.trim();
  //     String password = passwordController.text.trim();
  //     String phone = phoneController.text.trim();
  //     String age = agecontroller.text.trim();
  //     String blood = selectedValue.toString().trim();
  //     String username = usernameController.text.trim();

  //     if (_formKey.currentState!.validate()) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       if (_imageFile == null) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             backgroundColor: Colors.red,
  //             duration: Duration(seconds: 1),
  //             content: Text(
  //               'Please add your picture!',
  //             ),
  //           ),
  //         );
  //       } else {}
  //       await _auth
  //           .signUpWithEmailAndPassword(
  //         email,
  //         password,
  //       )
  //           .then((value) async {
  //         String userId = value!.uid;
  //         await FireService()
  //             .save_user(username, email, phone, age, blood, userId, _imageFile)
  //             .then((value) => Navigator.pushAndRemoveUntil(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => Client_BottomNav(),
  //                   ),
  //                   (route) => false,
  //                 ));
  //       });
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> _signUp() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String age = agecontroller.text.trim();
      String blood = selectedValue.toString().trim();
      String username = usernameController.text.trim();

      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        if (_imageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
              content: Text(
                'Please add your picture!',
              ),
            ),
          );
        } else {
          await _auth
              .signUpWithEmailAndPassword(email, password)
              .then((value) async {
            String userId = value!.uid;
            await FireService()
                .save_user(
                    username, email, phone, age, blood, userId, _imageFile)
                .then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Client_BottomNav(),
                      ),
                      (route) => false,
                    ));
          });
        }
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
 