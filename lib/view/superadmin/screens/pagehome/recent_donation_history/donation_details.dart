// import 'package:blood_donation/constants/const%20img.dart';
// import 'package:blood_donation/view/client/widgets/signup_button.dart';
// import 'package:blood_donation/view/superadmin/screens/pagehome/recent_donation_history/recent_donation_history_home.dart';
// import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../constants/color.dart';
// import '../../../../../sevice/user_Auth/auth_service.dart';
// import '../../../../widgets/bottomsheet.dart';
// import '../../../../widgets/pickimage.dart';
// import '../../../widgets/text_form_field.dart';
// import 'dart:io';
//
// class Super_DonationDetails extends StatefulWidget {
//   const Super_DonationDetails({super.key});
//
//   @override
//   State<Super_DonationDetails> createState() => _Super_DonationDetailsState();
// }
//
// class _Super_DonationDetailsState extends State<Super_DonationDetails> {
//   bool _isRegistering = false;
//   String? selectedgender;
//   final _formkey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final whomController = TextEditingController();
//   final pusposeController = TextEditingController();
//   final HospitalController = TextEditingController();
//   final List<String> bloodgroups = [
//     "A+",
//     "B+",
//     "AB+",
//     "RH+",
//     "O+",
//     "A-",
//     "AB-",
//     "RH-",
//     "B-",
//     "O-",
//   ];
//   final List<String> gender = ["Male", "Female", "Other"];
//
//   File? _pickedImage;
//   bool ispick = false;
//   late String? dateSelected;
//
//   String? selectedgroup;
//   Future _selectdate() async {
//     ispick = true;
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         dateSelected = picked.toString().split(" ")[0];
//       });
//     }
//     debugPrint(dateSelected);
//     return dateSelected;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title:  const Text("Donation history",style: TextStyle(color: Colours.white),),
//         backgroundColor: Colours.red,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formkey,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .02,
//                     ),
//                     CustomFormField(
//                       labeltxt: "Name",
//                       icons: const Icon(Icons.person),
//                       controller: nameController,
//                       validation: (value) {
//                         if (value!.isEmpty) {
//                           return "Required Field";
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     CustomFormField(
//                       labeltxt: "Email",
//                       icons: const Icon(Icons.email_outlined),
//                       controller: emailController,
//                       validation: (value) {
//                         if (value!.isEmpty) {
//                           return "Required Field";
//                         } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail.com$")
//                             .hasMatch(value)) {
//                           return "please enter valid email";
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     CustomFormField(
//                       icons: const Icon(Icons.person),
//
//                       labeltxt: "To whom",
//                       controller: whomController,
//                       validation: (value) {
//                         if (value!.isEmpty) {
//                           return "Required Field";
//                         }
//                       },
//                     ), SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     CustomFormField(
//
//                       labeltxt: "Hospital Name",
//                       icons: const Icon(Icons.local_hospital_outlined),
//                       controller: HospitalController,
//                       validation: (value) {
//                         if (value!.isEmpty) {
//                           return "Required Field";
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     TextFormField(
//                       controller: pusposeController,
//                       keyboardType: TextInputType.text,
//                       maxLines: 4,
//                       decoration: const InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colours.red,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colours.red,
//                             )),
//                         labelText: "Purpose",
//                         labelStyle: TextStyle(
//                             color: Colours.textLightBlack, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                             fixedSize: const Size(140, 64),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             foregroundColor: Colours.black,
//                             side: const BorderSide(
//                               color: Colours.lightRed,
//                             )),
//                         onPressed: () {
//                           _selectdate();
//                         },
//                         child: ispick
//                             ? Text(dateSelected!)
//                             : const Text("Choose Date")),
//
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * .9,
//                       height: MediaQuery.of(context).size.height * .3,
//                       child: _pickedImage != null
//                           ? Image.file(_pickedImage!)
//                           : null,
//                     ),
//                     SignUpOrSignInButton(
//                         buttonName: "Attach Image",
//                         onPress: () {
//                           showModalBottomSheet(
//                               context: context,
//                               builder: (BuildContext buildcontext) {
//                                 return BottomSheetModel(
//                                   bottomsheetname: "profile photo",
//                                   pickcamera: () async {
//                                     final image = await ImagePickerHelperC
//                                         .pickImageFromCamera();
//                                     if (image != null) {
//                                       setState(() {
//                                         _pickedImage = File(image.path);
//                                       });
//                                     }
//                                   },
//                                   pickgallery: () async {
//                                     final image1 = await ImagePickerHelperG
//                                         .pickImageFromGallery();
//                                     if (image1 != null) {
//                                       setState(() {
//                                         _pickedImage = File(image1.path);
//                                       });
//                                     }
//                                     ;
//                                   },
//                                   handeldelete: () {
//                                     setState(() {
//                                       _pickedImage = null;
//                                     });
//                                   },
//                                 );
//                               });
//                         }),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     _isRegistering
//                         ? const Center(child: CircularProgressIndicator())
//                         : SignUpOrSignInButton(
//                         buttonName: 'Update',
//                         onPress: () {
//                           if (!_isRegistering) {
//                             Super_add_History();
//                           }
//                         }),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                     TextButton(onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Super_RecentDonationHistoryHome(),
//                           ));
//                     }, child: Text("Check History",style: TextStyle(color: Colours.red),)),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .03,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Super_add_History() {
//     try {
//       setState(() {
//         _isRegistering = true;
//       });
//       String name = nameController.text;
//       String email = emailController.text;
//       String whome = whomController.text;
//       String purpose = pusposeController.text;
//       String hospital = HospitalController.text;
//       String date = dateSelected.toString();
//       if (_formkey.currentState!.validate()) {
//         _formkey.currentState!.save();
//         FireService()
//             .add_history(name, email, whome, hospital, purpose, date, _pickedImage)
//             .then((value) => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Super_RecentDonationHistoryHome(),
//             )));
//       }
//     } catch (e) {
//       print("add_Historyyyyyyyyyyyyyyyyyyyyyyyyyyyy${e}");
//     }finally {
//       setState(() {
//         _isRegistering = false;
//       });
//     }
//   }
// }
