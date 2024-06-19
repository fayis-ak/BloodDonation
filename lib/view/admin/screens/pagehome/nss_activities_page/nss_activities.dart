import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/nss_activities_page/add_nss_activities.dart';
import 'package:blood_donation/view/admin/screens/pagehome/nss_activities_page/edit_nss_activities.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/nss_activities_page/nss_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';

class NssActivities extends StatelessWidget {
  const NssActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Nss Activitiesf",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Admin_addNssActivities()));
              },
              icon: Icon(
                Icons.add,
                color: Colours.white,
              )),
        ],
      ),
      body: StreamBuilder(
        stream: firestore.collection(NssActivity).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            var activityList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: activityList.length,
              itemBuilder: (context, index) {
                var activityData = activityList[index].data();

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
                              height: MediaQuery.of(context).size.height * 0.2,
                              // width: MediaQuery.of(context).size.width * 0.3,
                              // height: MediaQuery.of(context).size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             Nss_Details_super(
                                  //               docId: activityData['docId'],
                                  //             )));
                                },
                                child: Image.network(
                                  activityData['image_url'] ?? "",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Delete"),
                                  content: const Text("Are You Sure Delete?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          FirebaseFirestore.instance
                                              .collection(NssActivity)
                                              .doc(activityList[index].id)
                                              .delete();
                                        },
                                        child: const Text("Yes")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No"))
                                  ],
                                ),
                              );
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
                                  builder: (context) => Nss_Details_super(
                                    docId: activityData['docId'],
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: const Color.fromARGB(255, 243, 1, 1),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          } else {
            return Text("No donor");
          }
        },
      ),
    );
  }
}
