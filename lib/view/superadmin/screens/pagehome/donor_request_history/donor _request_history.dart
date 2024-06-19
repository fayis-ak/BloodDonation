import 'dart:async';

import 'package:blood_donation/view/superadmin/screens/pagehome/donor_request_history/recent_donors.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';
import '../../../../../constants/firebase_const.dart';

class DonorRequestHistoryhome extends StatefulWidget {
  @override
  _DonorRequestHistoryhomeState createState() =>
      _DonorRequestHistoryhomeState();
}

class _DonorRequestHistoryhomeState extends State<DonorRequestHistoryhome> {
  late List<DocumentSnapshot> _donorRequests;
  late Timer _updateTimer;

  @override
  void initState() {
    super.initState();
    _donorRequests = [];
    fetchData();

    _updateTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Donor ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _donorRequests.length,
        itemBuilder: (context, index) {
          var donorRequest = _donorRequests[index];
          Timestamp registrationDate = donorRequest["registration_date"];
          DateTime registrationDateTime = registrationDate.toDate();

          return ListTile(
            contentPadding: EdgeInsets.all(20),
            title: Text(donorRequest['name']),
            subtitle: Text(donorRequest['blood']),
            trailing: Text(
              '${registrationDateTime.day}/${registrationDateTime.month}/${registrationDateTime.year}',
            ),
          );
        },
      ),
    );
  }

  void fetchData() {
    firestore
        .collection(DonorRegistration)
        .get()
        .then((QuerySnapshot querySnapshot) {
      DateTime oneMinuteAgo = DateTime.now().subtract(Duration(days: 2));
      setState(() {
        _donorRequests = querySnapshot.docs.where((donorRequest) {
          Timestamp registrationDate =
              donorRequest["registration_date"] as Timestamp;
          DateTime registrationDateTime = registrationDate.toDate();

          return !registrationDateTime.isBefore(oneMinuteAgo);
        }).toList();
      });
    }).catchError((error) {
      print("Error fetching data: $error");
    });
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }
}
