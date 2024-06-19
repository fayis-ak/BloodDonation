// import 'package:blood_donation/view/superadmin/screens/pagehome/admin%20request/add_admin.dart';
// import 'package:blood_donation/view/superadmin/screens/pagehome/admin%20request/edit_admin.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../constants/color.dart';
//
// class AdminHome extends StatefulWidget {
//   const AdminHome({super.key});
//
//   @override
//   State<AdminHome> createState() => _AdminHomeState();
// }
//
// class _AdminHomeState extends State<AdminHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Admins",
//           style: TextStyle(color: Colours.white),
//         ),
//         backgroundColor: Colours.red,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const AddAdmin()));
//               },
//               icon: const Icon(
//                 Icons.add,
//                 color: Colours.white,
//               ))
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: 3,
//         itemBuilder: (context,index){
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(onTap:(){
//             Navigator.push(context,MaterialPageRoute(builder: (context)=>const EditAdmin()));
//           },
//             child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 110,
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colours.red),
//                         borderRadius: BorderRadius.circular(20)),
//                     child:  Column(
//                       children: [
//                         SizedBox(
//                           height:MediaQuery.of(context).size.height*.01,
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: MediaQuery.of(context).size.height*.01,
//                             ),
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                   "https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg"),
//                               radius:MediaQuery.of(context).size.height*.05,
//                             ),
//                             SizedBox(
//                               width:MediaQuery.of(context).size.height*.04,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Name",
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Phone Number",
//                                   style: TextStyle(fontSize: 16),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         );}
//       ),
//
//
//     );
//   }
// }
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/admin%20Registeration/add_admin.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/admin%20Registeration/edit_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Adminss",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAdmin()),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colours.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firestore.collection(admin).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No admin found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var adminData = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditAdmin()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colours.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(adminData['image_url'] ?? ""),
                              radius: MediaQuery.of(context).size.height * 0.05,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  adminData['name'] ?? "Name",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  adminData['phone'] ?? "00000000",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
