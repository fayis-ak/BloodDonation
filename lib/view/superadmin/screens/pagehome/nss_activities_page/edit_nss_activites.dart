import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/bottomsheet.dart';
import '../../../../widgets/custom form field.dart';
import '../../../../widgets/pickimage.dart';
import '../../../widgets/signup_button.dart';

class EditNssActivities extends StatefulWidget {
  const EditNssActivities({super.key});

  @override
  State<EditNssActivities> createState() => _EditNssActivitiesState();
}

class _EditNssActivitiesState extends State<EditNssActivities> {
  @override
  Widget build(BuildContext context) {
    final _formkey=GlobalKey<FormState>();
    final titlecontroller=TextEditingController();
    final discreptioncontroller=TextEditingController();
    File? _pickedImage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colours.red,
        actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.edit,color:Colours.lightRed,)),
          IconButton(onPressed: (){}, icon:Icon(Icons.delete,color:Colours.lightRed,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*.01 ,),
              CustomFormField(
                labeltxt:"Title",
                controller:titlecontroller,
                validation: (value){
                  if(value==null||value.isEmpty){
                    return "Required";
                  }
                },
                icons: Icon(Icons.label),

              ),


              SizedBox(height:MediaQuery.of(context).size.height*.01 ,),
              CustomFormField(
                labeltxt:"discreptions",
                controller: discreptioncontroller,
                validation: (value){
                  if(value==null||value.isEmpty){
                    return "Required";
                  }
                },
                icons:Icon(Icons.keyboard),
                maxline: 5,
              ),

              SizedBox(height:MediaQuery.of(context).size.height*.01 ,),
              SizedBox(

                child:Row(mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.9,
                      height:MediaQuery.of(context).size.height*.3,
                      child: _pickedImage!=null? Image.file(_pickedImage!):null,
                    )
                  ],),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*.01 ,),
              SignUpOrSignInButton(buttonName: "Attach Image", onPress:(){
                showModalBottomSheet(context: context, builder: (BuildContext buildcontext){
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
              }
              ),
              SizedBox(height:MediaQuery.of(context).size.height*.01 ,),
              SignUpOrSignInButton(buttonName: "submit", onPress:(){
                if(_formkey.currentState!.validate()){
                  _formkey.currentState!.save();
                }
              } ),



            ],
          ),
        ),
      ),
    );
  }
}