import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

// import 'dart:developer';

// import 'package:blood_donation/constants/color.dart';
// import 'package:blood_donation/constants/firebase_const.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

class UserAcceptandDecline extends StatefulWidget {
  const UserAcceptandDecline({
    super.key,
    required this.bloodgroup,
    required this.bloodid,
    required this.docId,
    required this.unit,
  });
  final String bloodgroup;
  final String bloodid;
  final String docId;
  final String unit;

  @override
  State<UserAcceptandDecline> createState() => _UserAcceptandDeclineState();
}

class _UserAcceptandDeclineState extends State<UserAcceptandDecline> {
  bool isButtonVisible = false;

  final _formkey = GlobalKey<FormState>();
  List<String> tempArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "Share Doner",
              style: TextStyle(color: Colours.white),
            ),
          ),
          backgroundColor: Colours.red,
        ),
        body: Form(
            key: _formkey,
            child: StreamBuilder(
              stream: firestore
                  .collection(DonorRegistration)
                  .where('blood', isEqualTo: widget.bloodgroup)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data available.',
                    ),
                  );
                }

                var activityList = snapshot.data!.docs;
                int count = int.parse(widget.unit.toString());
                int difference = (activityList.length - count).abs();

                return ListView.builder(
                    itemCount: count != activityList.length
                        ? count < activityList.length
                            ? count
                            : activityList.length + difference
                        : count,
                    itemBuilder: (context, index) {
                      if (index < count && index < activityList.length) {
                        final document = activityList[index];
                        final name = document['name'] ?? '';
                        final address = document['adress'] ?? '';
                        final phone = document['phone'] ?? '';
                        final blood = document["blood"] ?? '';
                        final gender = document['gender'] ?? '';
                        final age = document['age'] ?? '';
                        final image = document['image_url'] ?? '';
                        final userid = document['uid'] ?? '';

                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            // width: MediaQuery.of(context).size.width,
                            // height: constraints.maxHeight * 0.335,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colours.red),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  image != null
                                      ? CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          backgroundImage: NetworkImage(image),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      // const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Address :$address",
                                                style: const TextStyle(),
                                              ),
                                              Text(
                                                "Ph : $phone",
                                                style: const TextStyle(),
                                              ),
                                              Text(
                                                "Group : $blood",
                                                style: const TextStyle(),
                                              ),
                                              Text(
                                                "Age : $age",
                                                style: const TextStyle(),
                                              ),
                                              Text(
                                                "Gender : $gender",
                                                style: const TextStyle(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (tempArray.contains(
                                                        name[index]
                                                            .toString())) {
                                                      tempArray.remove(
                                                          name[index]
                                                              .toString());
                                                    } else {
                                                      tempArray.add(name[index]
                                                          .toString());
                                                    }
                                                  });

                                                  sendPushNotification(
                                                      "New Donar Available",
                                                      widget.bloodid);
                                                  try {
                                                    firestore
                                                        .collection(
                                                            bloodrequest)
                                                        .doc(widget.docId)
                                                        .update({
                                                      'donarid':
                                                          FieldValue.arrayUnion(
                                                              [userid]),
                                                    }).then(
                                                      (value) => CustomToast
                                                          .showSuccessToast(
                                                        "successfully shared",
                                                      ),
                                                    );

                                                    print(
                                                      'UserID updated in blood_request collection successfully!',
                                                    );
                                                    setState(() {
                                                      isButtonVisible = true;
                                                    });
                                                  } catch (e) {
                                                    print(
                                                      'Error updating UserID in blood_request collection: $e',
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: tempArray.contains(
                                                      name[index].toString(),
                                                    )
                                                        ? Color.fromARGB(
                                                            143, 104, 103, 103)
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      tempArray.contains(
                                                              name[index]
                                                                  .toString())
                                                          ? "shared"
                                                          : "share",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Get more donors',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        );
                      }
                    });
              },
            )));
  }

  static Future<void> sendPushNotification(String msg, String id) async {
    try {
      var pushnotification = await FirebaseFirestore.instance
          .collection(client)
          .where('userId', isEqualTo: id)
          .get();
      print('bloodid  $id');

      if (pushnotification.docs.isNotEmpty) {
        var documentSnapshot = pushnotification.docs.first;

        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();

          if (data != null) {
            var token = data['push_token'];
            log(token);
            if (token != null) {
              final body = {
                "to": token,
                "notification": {
                  "title": "Blood Donation",
                  "body": msg,
                  "android_channel_id": "chats"
                },
                "data": {
                  "some_data": "User ID:  $id",
                },
              };
              var res = await http.post(
                  Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader:
                        'key=AAAATPS8ylI:APA91bH-sfgNYV4xvtFqe_Rexo8O6p8BCfkOfB0a8ms9QEhhbZRaUjMprcxz8rn7aQFLwM8pZvUxHntb6NQrT_w7mDz-dZRS5aG53MNH7acNUJ20vrdZp6V7w4oRY3Qtte6Co0UHXgeH'
                  },
                  body: jsonEncode(body));
            }
          }
        }
      }
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

}
