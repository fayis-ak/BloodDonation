// import 'dart:io';

// import 'package:blood_donation/constants/const%20img.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../../../constants/color.dart';
// import '../../../../client/widgets/signup_button.dart';
// import '../../../../widgets/bottomsheet.dart';
// import '../../../../widgets/custom form field.dart';
// import '../../../../widgets/pickimage.dart';
// class AddAmbulanceService extends StatefulWidget {
//   const AddAmbulanceService({super.key});

//   @override
//   State<AddAmbulanceService> createState() => _AddAmbulanceServiceState();
// }

// class _AddAmbulanceServiceState extends State<AddAmbulanceService> {
//   final formkey=GlobalKey<FormState>();
//   final drivername=TextEditingController();
//   final drivernumber=TextEditingController();
//   final vehicledetailsandlocation=TextEditingController();
//   File? _pickedImage;
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("data"),
//         backgroundColor:Colours.red,
//       ),
//       body:SingleChildScrollView(
//         child: Form(
//           key: formkey,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Stack(children: [
//                   CircleAvatar(
//                       radius:MediaQuery.of(context).size.height*.09,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage:_pickedImage!=null?
//                       FileImage(_pickedImage!):const AssetImage(imagepickerunnamed)as ImageProvider),

//                   Positioned(
//                       top:MediaQuery.of(context).size.height*.12,
//                       left: MediaQuery.of(context).size.height*.12,
//                       child: IconButton(onPressed:(){
//                         showModalBottomSheet(context: context, builder:(BuildContext builderContext){
//                           return BottomSheetModel(
//                             bottomsheetname:"profile photo",
//                             pickcamera:()async{
//                               final image=await ImagePickerHelperC.pickImageFromCamera();
//                               if(image!=null){
//                                 setState(() {
//                                   _pickedImage=File(image.path);});}},
//                             pickgallery:()async{
//                               final image1=await ImagePickerHelperG.pickImageFromGallery();
//                               if(image1!=null){
//                                 setState(() {
//                                   _pickedImage=File(image1.path);});};},
//                             handeldelete:(){
//                               setState(() {
//                                 _pickedImage=null;});},
//                           );
//                         });
//                       }, icon:Icon(Icons.camera_alt,color:Colours.lightRed,))
//                   ),
//                 ],),
//                 SizedBox(height:MediaQuery.of(context).size.height*.03,),
//                 SizedBox(height:MediaQuery.of(context).size.height*.02,),
//                 CustomFormField(
//                   labeltxt:"Driver Name",
//                   icons:Icon(Icons.person),
//                   controller: drivername,
//                   validation:(value){
//                     if(value==null||value.isEmpty){
//                       return "Required";
//                     }
//                   } ,
//                 ),

//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 CustomFormField(
//                   controller: drivernumber,
//                   textinputtype: TextInputType.number,
//                   validation:(value){
//                     if(value==null||value.isEmpty){
//                       return "Required";
//                     }else if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
//                       return 'Please enter a valid 10-digit phone number';
//                     }
//                   } ,
//                   icons:Icon(Icons.phone),
//                   labeltxt: "Driver number",
//                 ),

//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 CustomFormField(
//                   controller: vehicledetailsandlocation,
//                   validation:(value){
//                     if(value==null||value.isEmpty){
//                       return "Required";
//                     }
//                   },
//                   maxline: 5,
//                   labeltxt: "vehicle details and locations" ,
//                 ),

//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 SignUpOrSignInButton(buttonName: 'submit', onPress: () {
//                   if(formkey.currentState!.validate()){
//                     formkey.currentState!.save();
//                     Navigator.pop(context);
//                   }
//                 },),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }