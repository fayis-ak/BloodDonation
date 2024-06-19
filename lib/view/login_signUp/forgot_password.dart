import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/client/widgets/text_form_field.dart';
import 'package:blood_donation/view/home/home_page.dart';
import 'package:blood_donation/view/widgets/loading_button_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();
  String email = "";
  final _formKey = GlobalKey<FormState>();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: const Text(
          "Password Reset email has been sent",
          style: TextStyle(fontSize: 18),
        ),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: const Text(
            "No user found for that email",
            style: TextStyle(fontSize: 18),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.15,
                    ),
                    Column(
                      children: [
                        Text(
                          'Enter your email address to reset your password',
                          style: TextStyle(
                            color: Colours.lightRed,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Your forgot email enter and continue your new password ',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormFieldWidget(
                        label: "Email",
                        icon: const Icon(Icons.lock_open_rounded),
                        controller: emailcontroller,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: SignUpOrSignInButtonClient(
                            buttonName: "continue",
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailcontroller.text;
                                });
                                resetPassword();
                              }
                            },
                            isLoading: false))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
