import 'dart:developer';

import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/user_request/user_accept_and_decline.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AvailableDonors extends StatefulWidget {
  AvailableDonors({Key? key});
  //late String? _token;

  @override
  State<AvailableDonors> createState() => _AvailableDonorsState();
}

class _AvailableDonorsState extends State<AvailableDonors> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    bool isButtonPressed = false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Donors",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: user != null
            ? FirebaseFirestore.instance
                .collection(bloodrequest)
                .where('uid', isEqualTo: user.uid)
                .snapshots()
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donors'));
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var requestData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                Map<String, dynamic> donorIds = requestData;
                var donarId = requestData['donarid'];
                if (donarId == null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                      child: Text(
                        "----Processing Your ${requestData['blood']} Blood Request----",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  );
                }

                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(DonorRegistration)
                      .doc(donorIds['documentId'] as String?)
                      .snapshots(),
                  builder: (context, donorSnapshot) {
                    if (donorSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (donorSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${donorSnapshot.error}'));
                    }

                    var donorData = donorSnapshot.data;
                    if (donorData == null) {
                      return const Text("Not Fount");
                    }
                    // var donarId = requestData['donarid'];
                    // if (donarId == null) {
                    //   // Handle the case where 'donarid' is null
                    //   return Text(
                    //     "----Processing Your ${requestData['blood']} Blood Request----",
                    //   );
                    // }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${requestData['name'] ?? "Name"}",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .05,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    "Ph:${requestData['phone'] ?? "Phone Number"}",
                                    // style: const TextStyle(fontSize: 16),
                                  ),
                                  Row(children: [
                                    Text(
                                      "Age:${requestData['age'] ?? "age"}",
                                      // style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      requestData['blood'] ??
                                          "Blood Group not specified",
                                      style: const TextStyle(
                                          // fontSize: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.1,
                                          color:
                                              Color.fromARGB(255, 207, 2, 2)),
                                    ),
                                  ]),
                                  Text(
                                    "Date:${requestData['date'] ?? "date"}",
                                    //   style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: FireService.getdonardetails(
                                requestData['donarid']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  color: Colors.red,
                                );
                              } else if (snapshot.hasData) {
                                final data1 = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: data1.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Donor Details",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            Text(
                                              "${data1[index]['name']}",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Ph: ${data1[index]['phone']}",
                                              style: const TextStyle(),
                                            ),
                                            Text(
                                              "Age: ${data1[index]['age']}",
                                              style: const TextStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Text(
                                  "No Request For Blood",
                                  style: TextStyle(color: Colors.black),
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: ElevatedButton(
                                    onPressed: isButtonPressed
                                        ? null
                                        : () {
                                            setState(() {
                                              isButtonPressed = true;
                                            });
                                            FireService()
                                                .Add_history(requestData['uid'],
                                                    requestData['donarid'])
                                                .then((_) {
                                              CustomToast.showSuccessToast(
                                                  "Accepted");
                                            });
                                          },
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content:
                                                  const Text('Are you sure '),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await firestore
                                                          .collection(
                                                              bloodrequest)
                                                          .doc(requestData[
                                                              "docId"])
                                                          .delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Yes'))
                                              ],
                                            ));
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }

  Future<void> removeField(String documentId) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(bloodrequest);
    await collection.doc(documentId).update({
      'donarid': FieldValue.delete(),
    });
  }
}
