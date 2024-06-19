// import 'package:flutter/material.dart';

// import '../../../../../constants/color.dart';
// import '../../../../widgets/custom form field.dart';


// class UserAcceptandDecline extends StatefulWidget {
//   const UserAcceptandDecline({super.key});

//   @override
//   State<UserAcceptandDecline> createState() => _UserAcceptandDeclineState();
// }

// class _UserAcceptandDeclineState extends State<UserAcceptandDecline> {
//   final formkey=GlobalKey<FormState>();
//   final nameController=TextEditingController();
//   final numberController=TextEditingController();
//   final emailController=TextEditingController();
//   final passwordController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar:AppBar(

//         backgroundColor:Colours.red,
//       ),
//       body:SingleChildScrollView(
//         child: Form(
//           key: formkey,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Center(
//               child: Column(

//                 mainAxisAlignment:MainAxisAlignment.start,

//                 children: [
//                   CircleAvatar(
//                     radius:MediaQuery.of(context).size.height*.09,
//                     backgroundImage:NetworkImage("https://wallpapers.com/images/high/cool-profile-picture-awled9dwo4qq2yv2.webp"),

//                   ),
//                   SizedBox(height:MediaQuery.of(context).size.height*.09,),
//                   CustomFormField(controller:nameController,
//                     validation:(value){
//                       if(value==null||value.isEmpty){
//                         return "Required";
//                       }
//                     },labeltxt:"Name",icons:Icon(Icons.person),
//                   ),

//                   SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                   CustomFormField(
//                     controller:numberController,
//                     validation:(value){
//                       if(value==null||value.isEmpty){
//                         return "Required";
//                       }else if(!RegExp(r'^[0-9]{10}$').hasMatch(value)){
//                         return 'Please enter a valid 10-digit phone number';
//                       }
//                     },
//                     labeltxt:"phone number",icons:Icon(Icons.phone),
//                     textinputtype:TextInputType.number,

//                   ),

//                   SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                   CustomFormField(controller:emailController,
//                     validation:(value){
//                       if(value==null||value.isEmpty){
//                         return "Required";
//                       }
//                     },labeltxt:"email",icons:Icon(Icons.email),
//                   ),

//                   SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                   CustomFormField(
//                     controller:passwordController,validation:(value){
//                     if(value==null||value.isEmpty){
//                       return "Required";
//                     }
//                   },icons:Icon(Icons.lock),labeltxt: "password",
//                   ),

//                   SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                   CustomFormField(
//                     validation:(value){
//                       if(passwordController.text!=value){
//                         return "not match";
//                       }
//                     },icons:Icon(Icons.lock),labeltxt:"confirm password",
//                   ),

//                   SizedBox(height:MediaQuery.of(context).size.height*.05,),
//                   Row(
//                     mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                     children: [
//                     SizedBox(
//                       width:MediaQuery.of(context).size.width*.4,
//                       child: ElevatedButton(onPressed: (){
//                         if(formkey.currentState!.validate()){
//                           formkey.currentState!.save();
//                           Navigator.pop(context);
//                         }},
//                         child:Text("Accept",style:TextStyle(fontSize:20,color:Colours.white),),
//                         style:ButtonStyle(
//                           backgroundColor:MaterialStateProperty.all(Colours.red),
//                         ),
//                       ),
//                     ),
//                     // SizedBox(width:MediaQuery.of(context).size.width*.15,),
//                     SizedBox(
//                       width:MediaQuery.of(context).size.width*.4,
//                       child: ElevatedButton(onPressed: (){

//                       }, child:Text("Decline",style:TextStyle(fontSize:20,color:Colours.white),),
//                         style:ButtonStyle(
//                           backgroundColor:MaterialStateProperty.all(Colours.red),
//                         ),
//                       ),
//                     ),

//                   ],),


//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }