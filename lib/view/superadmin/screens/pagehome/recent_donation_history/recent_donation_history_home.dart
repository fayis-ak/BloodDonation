import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/client/screens/pagehome/blood_request_page/blood_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Super_RecentDonationHistoryHome extends StatefulWidget {
  const Super_RecentDonationHistoryHome({Key? key}) : super(key: key);

  @override
  State<Super_RecentDonationHistoryHome> createState() =>
      _Super_RecentDonationHistoryHomeState();
}

class _Super_RecentDonationHistoryHomeState
    extends State<Super_RecentDonationHistoryHome> {
  late Stream<QuerySnapshot> _donationHistoryStream;

  @override
  void initState() {
    super.initState();
    _donationHistoryStream = firestore.collection(History).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "Donation History",
              style: TextStyle(color: Colours.white),
            ),
          ),
          backgroundColor: Colours.red,
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                  width: double.infinity,
                  //height: 200.0,
                  //// Adjust height as needed
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder(
                          stream: _donationHistoryStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No data availab.'));
                            }

                            return Column(
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                Timestamp registrationDate =
                                    data["Update_date"] as Timestamp;
                                DateTime registrationDateTime =
                                    registrationDate.toDate();

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        StreamBuilder(
                                          stream: FireService.getBlooddetails(
                                              data?["ClientID"]),
                                          builder: (context, clientSnapshot) {
                                            if (clientSnapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!clientSnapshot
                                                    .hasData ||
                                                clientSnapshot
                                                    .data!.docs.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      'No client data available.'));
                                            }
                                            final clientData =
                                                clientSnapshot.data!.docs.first;

                                            return Row(
                                              children: [
                                                Text(
                                                  "${clientData?["name"]}",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(width: 50),
                                                Text(
                                                  "${clientData["blood"]}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    //const SizedBox(width: 50),

                                    Column(
                                      children: [
                                        StreamBuilder(
                                          stream: FireService.getdonardetails(
                                              data?["DonerID"]),
                                          builder: (context, donorSnapshot) {
                                            if (donorSnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!donorSnapshot.hasData ||
                                                donorSnapshot
                                                    .data!.docs.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      'No donor data available.'));
                                            } else if (snapshot.hasData) {
                                              final List<dynamic> donorData =
                                                  donorSnapshot.data!.docs
                                                      .map((doc) => doc.data())
                                                      .toList();

                                              return Column(
                                                children: List.generate(
                                                    donorData.length,
                                                    (donorIndex) {
                                                  return Row(
                                                    children: [
                                                      const SizedBox(width: 50),
                                                      Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          Text(
                                                            "${donorData[donorIndex]["name"]}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 50),
                                                      Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          Text(
                                                            '${registrationDateTime.day}/${registrationDateTime.month}/${registrationDateTime.year}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              );
                                            } else {
                                              return const Text(
                                                "No Request For Blood",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }),
                            );
                          }))),
            )));
  }
}
