import 'package:blood_donation/constants/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:super_banners/super_banners.dart';

import '../../../../../constants/color.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/user_request/user_accept_and_decline.dart';

class UserRequestHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            "User Requests",
            style: TextStyle(color: Colours.white),
          ),
        ),
        backgroundColor: Colours.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(bloodrequest).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available.'));
          }
          final userRequests = snapshot.data?.docs ?? [];

          return LayoutBuilder(  
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: userRequests.length,
                itemBuilder: (context, index) {
                  final document = userRequests[index];
                  final name = document['name'] ?? '';
                  final address = document['address'] ?? '';
                  final phone = document['phone'] ?? '';
                  final blood = document['blood'] ?? '';
                  final gender = document['gender'] ?? '';
                  final id = document['uid'] ?? '';
                  final age = document['age'] ?? '';
                  final Unit = document['bloodUint'] ?? '';

                  return Stack(
                    children: [
                      Visibility(
                        visible: document['emergency'] == true,
                        child: const Positioned(
                          right: 10,
                          top: 10,
                          child: CornerBanner(
                            bannerPosition: CornerBannerPosition.topRight,
                            bannerColor: Colors.red,
                            child: Text(
                              'Urgent',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colours.red),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    // fontSize: constraints.maxWidth * .050,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address :$address",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    // overflow: TextOverflow.fade,
                                  ),
                                  Text(
                                    "Ph : $phone",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  Text(
                                    "Group : $blood",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  Text(
                                    "Age : $age",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  Text(
                                    "Gender : $gender",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  Text(
                                    "Blood Unit : $Unit",
                                    // style: TextStyle(
                                    //   fontSize: constraints.maxWidth * .040,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserAcceptandDecline(
                                                bloodgroup: blood,
                                                bloodid: id,
                                                docId: document.id,
                                                unit:Unit,
                                                

                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Doners",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
