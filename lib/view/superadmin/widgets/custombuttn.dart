import 'package:flutter/material.dart';
import 'package:blood_donation/constants/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.223,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 10, color: Colours.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colours.red),
        ),
      ),
    );
  }
}
