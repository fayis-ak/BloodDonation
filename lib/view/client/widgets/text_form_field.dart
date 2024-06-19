import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final Icon? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String> validation;
  final int? maxAgeLength;
  final bool? obscuretextd;
  final Icon? suffixIcon;
  final IconButton? suffixIconButton;
  TextFormFieldWidget({
    super.key,
    this.keyboardType,
    required this.label,
    this.icon,
    required this.controller,
    required this.validation,
    this.maxAgeLength,
    this.obscuretextd,
    this.suffixIcon,
    this.suffixIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          suffixIcon: suffixIconButton,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colours.lightRed,
            ),
          ),
          // focusColor: Colours.lightRed,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colours.lightRed,
            ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colours.lightRed,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          label: Text(
            label,
            style: const TextStyle(
                color: Colours.textLightBlack, fontWeight: FontWeight.w500),
          ),
          prefixIcon: icon,
          prefixIconColor: Colours.lightRed),
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxAgeLength),
      ],
      obscureText: obscuretextd ?? false,
    );
  }
}
