import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';

import 'package:blood_donation/view/client/bottomnav.dart';
import 'package:blood_donation/view/client/screens/pagehome/hompage.dart';
import 'package:blood_donation/view/client/widgets/signup_button.dart';
import 'package:blood_donation/view/client/widgets/text_form_field.dart';
import 'package:blood_donation/view/login_signUp/client_signUp.dart';
import 'package:blood_donation/view/login_signUp/forgot_password.dart';
import 'package:blood_donation/view/widgets/loading_button_client.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FireService _auth = FireService();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset("assets/images/blood.jpg"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                      label: "email",
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
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormFieldWidget(
                    label: "password",
                    icon: const Icon(Icons.lock_open_rounded),
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUP()));
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(color: Colours.lightRed),
                        ),
                      )
                    ],
                  )
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
              builder: (context) => Client_BottomNav(),
            ),
            (route) => false,
          );
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
