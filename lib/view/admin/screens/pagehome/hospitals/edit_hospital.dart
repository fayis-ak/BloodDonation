import 'dart:io';

import 'package:blood_donation/constants/const%20img.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';
import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/custom form field.dart';
import '../../../../widgets/pickimage.dart';

class EditHospital extends StatefulWidget {
  const EditHospital({super.key});

  @override
  State<EditHospital> createState() => _EditHospitalState();
}

class _EditHospitalState extends State<EditHospital> {
  final formkey=GlobalKey<FormState>();

  final hospitalname=TextEditingController();

  final hospitalnumber=TextEditingController();

  final hospitaldetailsandlocation=TextEditingController();

  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Edit Hospital"),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*.02,),
                Stack(children: [
                  CircleAvatar(
                      radius:MediaQuery.of(context).size.height*.09,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:_pickedImage!=null?
                      FileImage(_pickedImage!):const AssetImage(imagepickerunnamed)as ImageProvider),

                  Positioned(
                      top:MediaQuery.of(context).size.height*.12,
                      left: MediaQuery.of(context).size.height*.12,
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
                CustomFormField(
                  labeltxt:"Hospital Name" ,
                  icons: Icon(Icons.local_hospital),
                  controller: hospitalname,
                  validation:  (value){
                    if(value==null||value.isEmpty){
                      return "Required";
                    }
                  },
                ),

                SizedBox(height:MediaQuery.of(context).size.height*.01,),
                CustomFormField(
                  labeltxt: "Hospital Number",
                  icons: Icon(Icons.phone),
                  controller:hospitalnumber,
                  textinputtype:TextInputType.number,
                  validation:   (value){
                    if(value==null||value.isEmpty){
                      return "Required";
                    }else if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
                      return 'Please enter a valid 10-digit phone number';
                    }
                  } ,

                ),
                //
                SizedBox(height:MediaQuery.of(context).size.height*.01,),
                CustomFormField(
                  controller:hospitaldetailsandlocation,
                  labeltxt: "Hospital details and locations",
                  validation:  (value){
                    if(value==null||value.isEmpty){
                      return "Required";
                    }
                  },
                  maxline:5,
                ),

                SizedBox(height:MediaQuery.of(context).size.height*.02,),

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
    );
  }
}
