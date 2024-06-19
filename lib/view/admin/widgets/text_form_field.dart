
import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
 final  String label;
 final Icon icon;
 final TextEditingController controller;
 final TextInputType? keyboardType;
 final FormFieldValidator<String> validation;
  const TextFormFieldWidget({super.key,this.keyboardType, required this.label, required this.icon, required this.controller, required this.validation});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      controller:controller ,
      validator: validation,
      keyboardType:keyboardType ,
      decoration:InputDecoration(
          focusedBorder:const OutlineInputBorder(
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
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          label: Text(label,style:const  TextStyle(color: Colours.textLightBlack,fontWeight: FontWeight.w500),),
          prefixIcon: icon,
          prefixIconColor: Colours.lightRed
      ),
    );

  }
}
