// import 'package:flutter/material.dart';

// import '../../../../widgets/custom form field.dart';

// class ForDonorRequiest extends StatefulWidget {
//   const ForDonorRequiest({super.key});

//   @override
//   State<ForDonorRequiest> createState() => _ForDonorRequiestState();
// }

// class _ForDonorRequiestState extends State<ForDonorRequiest> {
//   final patientname=TextEditingController();
//   final patientnumber=TextEditingController();
//   final patienthospitaladdress=TextEditingController();
//   final patientage=TextEditingController();
//   final patientblood=TextEditingController();
//   final patientdate=TextEditingController();
//   final patientgender=TextEditingController();
//   final patientunitofblood=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar:AppBar(
//         title:Text("Donor Requiest"),
//       ),
//       body:SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://wallpapers.com/images/featured-full/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
//                   radius:MediaQuery.of(context).size.height*.08,
//                 ),
//                 SizedBox(height:MediaQuery.of(context).size.height*.02,),
//                 CustomFormField(
//                   labeltxt: "patient name",
//                   icons: Icon(Icons.person),
//                   controller:patientname,
//                 ),
//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 CustomFormField(
//                   labeltxt: "patient number",
//                   icons: Icon(Icons.phone),
//                   controller:patientnumber,
//                 ),
//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 CustomFormField(
//                   labeltxt: "patient Hospital Address",
//                   controller:patienthospitaladdress,
//                   maxline:4,
//                 ),
//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment:MainAxisAlignment.spaceBetween,


//                     children: [
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width*.28,
//                         child: CustomFormField(
//                           labeltxt: "Age",
//                           icons:Icon(Icons.numbers),
//                           controller:patientage,
//                         ),
//                       ),
//                       SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width*.38,
//                         child: CustomFormField(
//                           labeltxt: "blood type",
//                           icons:Icon(Icons.bloodtype_rounded),
//                           controller:patientblood,
//                         ),
//                       ),
//                       SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width*.31,
//                         child: CustomFormField(
//                           labeltxt: "Required Date",
//                           icons:Icon(Icons.numbers),
//                           controller:patientdate,
//                         ),
//                       ),
//                       SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width*.31,
//                         child: CustomFormField(
//                           labeltxt: "Gender",
//                           controller:patientgender,
//                         ),
//                       ),
//                       SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width*.31,
//                         child: CustomFormField(
//                           labeltxt: "Unit of Blood",
//                           controller:patientunitofblood,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height:MediaQuery.of(context).size.height*.01,),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );;
//   }
// }
