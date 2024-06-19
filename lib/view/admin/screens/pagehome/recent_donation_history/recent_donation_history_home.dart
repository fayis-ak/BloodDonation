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
        child: SizedBox(
          child: StreamBuilder(
            stream: _donationHistoryStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No History Available.'));
              }
              // final data = snapshot.data!.docs.first;

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  Timestamp registrationDate = data["Update_date"] as Timestamp;
                  DateTime registrationDateTime = registrationDate.toDate();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder(
                            stream:
                                FireService.getBlooddetails(data["ClientID"]),
                            builder: (context, clientSnapshot) {
                              if (clientSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (!clientSnapshot.hasData ||
                                  clientSnapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text('No client data available.'));
                              }
                              final clientData =
                                  clientSnapshot.data!.docs.first;
                              return Text(
                                "${clientData["name"]}",
                                style: const TextStyle(fontSize: 18),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          StreamBuilder(
                            stream:
                                FireService.getdonardetails(data["DonerID"]),
                            builder: (context, donorSnapshot) {
                              if (donorSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (!donorSnapshot.hasData ||
                                  donorSnapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text('No donor data available.'));
                              }
                              final donorData = donorSnapshot.data!.docs.first;
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${donorData["blood"]}",
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${donorData["name"]}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '${registrationDateTime.day}/${registrationDateTime.month}/${registrationDateTime.year}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
