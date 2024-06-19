import 'package:blood_donation/constants/firebase_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/color.dart';

class ClientAmbulanceService extends StatelessWidget {
  const ClientAmbulanceService({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Ambulance Service",
            style: TextStyle(color: Colours.white),
          ),
          backgroundColor: Colours.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: firestore.collection(Ambulance_service).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Ambulance Service.'));
              } else {
                var ambulanceData = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: ambulanceData.length,
                  itemBuilder: (context, index) {
                    var data = ambulanceData[index];
                    double avatarRadius =
                        MediaQuery.of(context).size.height * 0.035;
                    double containerHeight =
                        MediaQuery.of(context).size.height * 0.18;
                    double fontSizeTitle =
                        MediaQuery.of(context).size.width * 0.05;
                    double fontSizeSubtitle =
                        MediaQuery.of(context).size.width * 0.04;

                    // return Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 10),
                    //   height: containerHeight * 0.9,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: Border.all(
                    //       color: Colours.red,
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const SizedBox(width: 5),
                    //       CircleAvatar(
                    //         radius: avatarRadius,
                    //         backgroundImage: NetworkImage(data['image_url'] ??
                    //             const CircularProgressIndicator()),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 data['name'] ?? "Name Not Available",
                    //                 style: TextStyle(
                    //                   fontSize: fontSizeTitle,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 data['location'] ??
                    //                     "Location Not Available",
                    //                 style: TextStyle(
                    //                     // fontSize: fontSizeSubtitle,
                    //                     ),
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   GestureDetector(
                    //                     onTap: () {
                    //                       final phone = data['number'];
                    //                       if (phone != null) {
                    //                         ("tel:$phone");
                    //                       }

                    //                       launch("tel:${data['number']}");
                    //                     },
                    //                     child: Text(data['number'] ?? ""),
                    //                   ),
                    //                   IconButton(
                    //                     onPressed: () {},
                    //                     icon: const Icon(
                    //                       Icons.phone,
                    //                       color: Colors.blue,
                    //                       size: 20,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );

                    return SizedBox(
                      
                      height: MediaQuery.of(context).size.height * .12,
                       child: Card(
                        child: ListTile(
                          title: Text(
                            data['name'] ?? "Name Not Available",
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            data['location'] ?? "Location Not Available",
                            style: TextStyle(
                              fontSize: fontSizeSubtitle,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: avatarRadius,
                            backgroundImage: NetworkImage(data['image_url'] ??
                                const CircularProgressIndicator()),
                          ),
                          trailing: Wrap(
                            spacing: 12,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  final phone = data['number'];
                                  if (phone != null) {
                                    ("tel:$phone");
                                  }

                                  launch("tel:${data['number']}");
                                },
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                              ),
                              // Icon(Icons.message),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
