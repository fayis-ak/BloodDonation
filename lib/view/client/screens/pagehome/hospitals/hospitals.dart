import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class client_hospital extends StatelessWidget {
  const client_hospital({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Hospitals", style: TextStyle(color: Colours.white)),
        backgroundColor: Colours.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection(Hospitals).snapshots(),
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

                var hospitalList = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: hospitalList.length,
                  itemBuilder: (context, index) {
                    var hospitalData = hospitalList[index].data();

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: constraints.maxHeight * .20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colours.red,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: Colors.red.shade400,
                            radius: constraints.maxWidth * 0.08,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(hospitalData['photo'] ?? ''),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    hospitalData['name'] ?? "",
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(hospitalData['location'] ?? ""),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final phone = hospitalData['phone'];
                                          if (phone != null) {
                                            ("tel:$phone");
                                          }

                                          launch(
                                              "tel:${hospitalData['phone']}");
                                        },
                                        child:
                                            Text(hospitalData['phone'] ?? ""),
                                      ),
                                      if (hospitalData['phone'] != null)
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.phone,
                                              color: Colors.blue),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
