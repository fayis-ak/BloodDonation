import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Nss_Details_super extends StatefulWidget {
  Nss_Details_super({super.key, this.docId});
  final docId;

  @override
  State<Nss_Details_super> createState() => _Nss_Details_super();
}

class _Nss_Details_super extends State<Nss_Details_super> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: const Text(
            'Event Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
          stream: FireService.find_Acti(widget.docId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data available.'));
            }

            var nssactivityList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: nssactivityList.length,
              itemBuilder: (context, index) {
                var nssdata = nssactivityList[index].data();

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(26, 255, 0, 0),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nssdata['title'] ?? "Title",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          nssdata['discreption'] ?? "About program",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
