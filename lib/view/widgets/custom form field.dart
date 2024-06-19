import 'package:blood_donation/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
  final Icon? icons;
  final int? maxlength;
  final int? maxline;
  final TextInputType? textinputtype;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final String? labeltxt;
  const CustomFormField({
    super.key,
    this.labeltxt,
    this.validation,
    this.controller,
    this.textinputtype,
    this.maxline,
    this.maxlength,
    this.icons,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validation,
      keyboardType: widget.textinputtype,
      maxLines: widget.maxline,
      // maxLength: widget.maxlength,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxlength),
      ],
      decoration: InputDecoration(
          prefixIcon: widget.icons,
          prefixIconColor: Colours.lightRed,
          labelStyle: TextStyle(
              color: Colours.textLightBlack, fontWeight: FontWeight.w500),
          labelText: widget.labeltxt,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colours.lightRed,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colours.lightRed)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colours.lightRed,
          ))),
    );
  }
}
