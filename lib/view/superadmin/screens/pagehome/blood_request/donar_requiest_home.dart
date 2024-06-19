import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/blood_request/for_donor_requiest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';
import '../../../../widgets/custom_toast.dart';

class DonorRequestHome_super extends StatefulWidget {
  const DonorRequestHome_super({super.key});

  @override
  State<DonorRequestHome_super> createState() => _DonorRequestHome_superState();
}

class _DonorRequestHome_superState extends State<DonorRequestHome_super> {
  List<DocumentSnapshot> donorRequests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Blood Requests",
            style: TextStyle(color: Colours.white)),
        backgroundColor: Colours.red,
      ),
      body: StreamBuilder(
        stream: firestore.collection(bloodrequest).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donor requests found.'));
          }

          donorRequests =
              snapshot.data!.docs; // Save the list for future reference

          return LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: donorRequests.length,
                itemBuilder: (context, index) {
                  var donorData = donorRequests[index];
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ForDonorRequiest()),
                      // );
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(constraints.maxWidth * 0.02),
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colours.red,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.ltr,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth * 0.02,
                                  top: constraints.maxWidth * 0.02),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: constraints.maxHeight * 0.05,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  donorData['name'],
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.05,
                                      color: Colours.red),
                                ),
                                Text(
                                  donorData['date'],
                                  style: const TextStyle(
                                      // fontSize: constraints.maxWidth * 0.04,
                                      color: Colours.red),
                                ),
                                Text(
                                  donorData['address'],
                                  style: const TextStyle(
                                    // fontSize: constraints.maxWidth * 0.04,
                                    color: Colours.red,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: constraints.maxWidth * 0.1,
                              width: constraints.maxWidth * 0.225,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text('Are you sure '),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            CustomToast.showSuccessToast(
                                                "Successfully Decline");
                                            firestore
                                                .collection(bloodrequest)
                                                .doc(donorData.id)
                                                .delete();
                                          },
                                          child: const Text('Yes'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.027,
                                      color: Colours.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colours.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
