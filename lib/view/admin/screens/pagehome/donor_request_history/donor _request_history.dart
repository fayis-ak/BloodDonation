import 'dart:async';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_DonorRequestHistoryhome extends StatefulWidget {
  @override
  _Admin_DonorRequestHistoryhomeState createState() =>
      _Admin_DonorRequestHistoryhomeState();
}

class _Admin_DonorRequestHistoryhomeState
    extends State<Admin_DonorRequestHistoryhome> {
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
        title: Text(
          'Donor ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colours.red,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _donorRequests.length,
        itemBuilder: (context, index) {
          var donorRequest = _donorRequests[index];
          Timestamp registrationDate = donorRequest["registration_date"];
          DateTime registrationDateTime = registrationDate.toDate();

          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ListTile(
              title: Text(
                donorRequest['name'],
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                donorRequest['blood'],
                style: TextStyle(fontSize: 18),
              ),
              trailing: Text(
                '${registrationDateTime.day}/${registrationDateTime.month}/${registrationDateTime.year}',
              ),
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
