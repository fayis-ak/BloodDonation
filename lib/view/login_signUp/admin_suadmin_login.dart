import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/superadmin/bottomnav.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/hompage.dart';
import 'package:blood_donation/view/widgets/loading_button_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../sevice/user_Auth/auth_service.dart';
import '../admin/bottomnav.dart';

import '../widgets/custom form field.dart';

class Admiss_login extends StatefulWidget {
  const Admiss_login({Key? key}) : super(key: key);

  @override
  State<Admiss_login> createState() => _Admiss_loginState();
}

class _Admiss_loginState extends State<Admiss_login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final FireService _auth = FireService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .300,
                    width: MediaQuery.of(context).size.width * .9,
                    child: Image.asset("assets/images/adminloggin.png"),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                      controller: emailController,
                      labeltxt: "email",
                      icons: Icon(Icons.email_outlined),
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                      }),
                  // TextFormFieldWidget(
                  //   label: "email",
                  //   icon: const Icon(Icons.email_outlined),
                  //   controller: emailController,
                  //   validation: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Enter email";
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 26),
                  CustomFormField(
                    labeltxt: 'password',
                    icons: Icon(Icons.lock_open_rounded),
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      }
                    },
                  ),
                  // TextFormFieldWidget(
                  //   label: "password",
                  //   icon: const Icon(Icons.lock_open_rounded),
                  //   controller: passwordController,
                  //   validation: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Enter password";
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  SignUpOrSignInButtonClient(
                    buttonName: "Sign-In",
                    onPress: () {
                      final valid = formKey.currentState!.validate();
                      if (valid) {
                        _signIn();
                        formKey.currentState!.save();
                      }
                    },
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      setState(() {
        isLoading = true;
      });
      await _auth
          .signInWithEmailAndPassword(email, password, context)
          .then((value) {
        if (value != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AdminBottomNav(),
              ),
              (route) => false);
        } else {
           print('error login');
          // Fluttertoast.showToast(
          //   msg: "error!",
          // );
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
