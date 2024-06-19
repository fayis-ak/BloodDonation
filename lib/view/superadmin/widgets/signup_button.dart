import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

class SignUpOrSignInButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPress;
  const SignUpOrSignInButton(
      {super.key, required this.buttonName, required this.onPress});

  @override
  State<SignUpOrSignInButton> createState() => _SignUpOrSignInButtonState();
}

class _SignUpOrSignInButtonState extends State<SignUpOrSignInButton> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .05,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colours.red,
              fixedSize: const Size(370, 44),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () {
            setState(() {
              isloading = true;
            });
            widget.onPress();
            Future.delayed(Duration(seconds: 5), () {
              setState(() {
                isloading = false;
              });
            });
          },
          child: isloading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  widget.buttonName,
                  style: const TextStyle(
                      color: Colours.white, fontWeight: FontWeight.w500),
                )),
    );
  }
}
