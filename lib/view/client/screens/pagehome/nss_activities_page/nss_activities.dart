import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/nss_activities_page/add_nss_activities.dart';

import 'package:blood_donation/view/client/screens/pagehome/nss_activities_page/Details.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/nss_activities_page/nss_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../constants/firebase_const.dart';
import '../hospitals/hospitals.dart';

class Client_NssActivities extends StatelessWidget {
  Client_NssActivities({Key? key});
  final User? user = fire_auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(" Activities",
            style:
                TextStyle(color: Colours.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colours.red,
      ),
      body: StreamBuilder(
        stream: user != null
            ? FirebaseFirestore.instance.collection(NssActivity).snapshots()
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              var activityList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: activityList.length,
                itemBuilder: (context, index) {
                  var activityData = activityList[index];

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Card(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colours.red),
                            ),
                            child: InkWell(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Image.network(
                                  activityData['image_url'] ?? "",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Nss_Details_clinet(
                                //       docId: activityData['docId'],
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width * .05,
                            top: MediaQuery.of(context).size.width * .15,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Nss_Details_clinet(
                                      docId: activityData['docId'],
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 255, 1, 1),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              );
            } else {
              return const Center(child: Text('No Activities'));
            }
          } else {
            return const Center(child: Text('No Activities'));
          }
        },
      ),
    );
  }
}
