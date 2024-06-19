import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/superadmin/bottomnav.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/hompage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../sevice/user_Auth/auth_service.dart';
import '../admin/bottomnav.dart';
import '../admin/screens/pagehome/hompage.dart';
import '../admin/widgets/signup_button.dart';
import '../admin/widgets/text_form_field.dart';
import '../widgets/custom form field.dart';

class Super_login extends StatefulWidget {
  const Super_login({Key? key}) : super(key: key);

  @override
  State<Super_login> createState() => _Super_loginState();
}

class _Super_loginState extends State<Super_login> {
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
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .300,
                    width: MediaQuery.of(context).size.width * .800,
                    child: Image.asset("assets/images/superadmin.jpg"),
                  ),
                  // const SizedBox(height: 10),
                  CustomFormField(
                      controller: emailController,
                      labeltxt: "email",
                      icons: Icon(Icons.email_outlined),
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      }),
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
                  const SizedBox(height: 40),
                  isLoading
                      ? CircularProgressIndicator()
                      : SignUpOrSignInButton(
                          buttonName: "Sign-In",
                          onPress: () {
                            final valid = formKey.currentState!.validate();
                            if (valid) {
                              super_signIn();
                              formKey.currentState!.save();
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

  Future<void> super_signIn() async {
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
                builder: (context) => SuperAdminBottomNav(),
              ),
              (route) => false);
        } else {
          print('error login');
          // Fluttertoast.showToast(
          //   msg: "error login",
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
