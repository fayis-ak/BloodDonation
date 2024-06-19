import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/hospitals/add_hospital_details.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/hospitals/edit_hospital.dart';
import 'package:blood_donation/view/widgets/customalertbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Super_Hospitals extends StatelessWidget {
  const Super_Hospitals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Hospitals",
            style: TextStyle(color: Colours.white),
          ),
          backgroundColor: Colours.red,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddHospitalDetails()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colours.white,
                ))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(Hospitals).snapshots(),
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

            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ListView.builder(
                  itemCount: hospitalList.length,
                  itemBuilder: (context, index) {
                    var hospitalData = hospitalList[index].data();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          //padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // height: constraints.maxHeight * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colours.red,
                            ),
                          ),
                          child: InkWell(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.red.shade400,
                                  radius: constraints.maxWidth * 0.08,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(hospitalData['photo']),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          hospitalData['name'] ??
                                              "Hospital Name",
                                          style: TextStyle(
                                            fontSize:
                                                constraints.maxWidth * 0.05,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(hospitalData['location'] ??
                                            "Hospital Location"),
                                        //  SizedBox(height: 8),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                final phone =
                                                    hospitalData['phone'];
                                                if (phone != null) {
                                                  ("tel:$phone");
                                                }

                                                launch(
                                                    "tel:${hospitalData['phone']}");
                                              },
                                              child: Text(
                                                  hospitalData['phone'] ?? ""),
                                            ),
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
                                        firestore
                                            .collection(Hospitals)
                                            .doc(hospitalList[index].id)
                                            .delete();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
