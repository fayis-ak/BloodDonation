import 'dart:io';
import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/admin/widgets/signup_button.dart';
import 'package:blood_donation/view/admin/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/custom form field.dart';
import '../../../../widgets/pickimage.dart';

class EditAdmin extends StatefulWidget {
  const EditAdmin({super.key});

  @override
  State<EditAdmin> createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  final formkey=GlobalKey<FormState>();
  final nameController=TextEditingController();
  final numberController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
resizeToAvoidBottomInset: false,
      appBar:AppBar(

        backgroundColor:Colours.red,
      ),
      body:SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(

                mainAxisAlignment:MainAxisAlignment.start,

                children: [
                  Stack(children: [
                    CircleAvatar(
                        radius:MediaQuery.of(context).size.height*.09,
                        backgroundImage:_pickedImage!=null?FileImage(_pickedImage!):null
                    ),
                    Positioned(
                        top:MediaQuery.of(context).size.height*.12,
                        left: MediaQuery.of(context).size.height*.11,
                        child: IconButton(onPressed:(){
                          showModalBottomSheet(context: context, builder:(BuildContext builderContext){
                            return BottomSheetModel(
                              bottomsheetname:"profile photo",
                              pickcamera:()async{
                                final image=await ImagePickerHelperC.pickImageFromCamera();
                                if(image!=null){
                                  setState(() {
                                    _pickedImage=File(image.path);});}},
                              pickgallery:()async{
                                final image1=await ImagePickerHelperG.pickImageFromGallery();
                                if(image1!=null){
                                  setState(() {
                                    _pickedImage=File(image1.path);});};},
                              handeldelete:(){
                                setState(() {
                                  _pickedImage=null;});},
                            );
                          });
                        }, icon:Icon(Icons.camera_alt,color:Colours.lightRed,))
                    ),
                  ],),

                  SizedBox(height:MediaQuery.of(context).size.height*.02,),

                  SizedBox(height:MediaQuery.of(context).size.height*.03,),
                  CustomFormField(controller:nameController,
                    validation:(value){
                      if(value==null||value.isEmpty){
                        return "Required";
                      }
                    },labeltxt:"Name",icons:Icon(Icons.person),),

                  SizedBox(height:MediaQuery.of(context).size.height*.01,),
                  CustomFormField(
                    controller:numberController,
                    validation:(value){
                      if(value==null||value.isEmpty){
                        return "Required";
                      }else if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
                        return 'Please enter a valid 10-digit phone number';
                      }
                    },
                    labeltxt:"phone number",icons:Icon(Icons.phone),
                    textinputtype:TextInputType.number,


                  ),

                  SizedBox(height:MediaQuery.of(context).size.height*.01,),
                  CustomFormField(controller:emailController,
                    validation:(value){
                      if(value==null||value.isEmpty){
                        return "Required";
                      }else if(!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail.com$").hasMatch(value)){
                        return "please enter valid email";
                      }
                    },labeltxt:"email",icons:Icon(Icons.email),),

                  SizedBox(height:MediaQuery.of(context).size.height*.01,),
                  CustomFormField(
                    controller:passwordController,validation:(value){
                    if(value==null||value.isEmpty){
                      return "Required";
                    }
                  },icons:Icon(Icons.lock),labeltxt: "password",),

                  SizedBox(height:MediaQuery.of(context).size.height*.01,),
                  CustomFormField(
                    validation:(value){
                      if(passwordController.text!=value){
                        return "not match";
                      }
                    },icons:Icon(Icons.lock),labeltxt:"confirm password",
                  ),

                  SizedBox(height:MediaQuery.of(context).size.height*.05,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                      width:MediaQuery.of(context).size.width*.4,
                      child: ElevatedButton(onPressed: (){
                        if(formkey.currentState!.validate()){
                          formkey.currentState!.save();
                          Navigator.pop(context);
                        }},
                          child:Text("Edit",style:TextStyle(fontSize:20,color:Colours.white),),
                        style:ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(Colours.red),
                        ),
                      ),
                    ),

                    SizedBox(
                      width:MediaQuery.of(context).size.width*.4,
                      child: ElevatedButton(onPressed: (){

                      }, child:Text("Delete",style:TextStyle(fontSize:20,color:Colours.white),),
                        style:ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(Colours.red),
                        ),
                      ),
                    ),

                  ],),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
