import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/donor_request/for_donor_requiest.dart';
import 'package:blood_donation/view/superadmin/widgets/signup_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';

class DonorRequestHome extends StatefulWidget {
  const DonorRequestHome({super.key});

  @override
  State<DonorRequestHome> createState() => _DonorRequestHomeState();
}

class _DonorRequestHomeState extends State<DonorRequestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "DonarRequest",
            style: TextStyle(color: Colours.white),
          ),
          backgroundColor: Colours.red,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
          stream: firestore.collection(DonorRegistration).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Not found.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var serviceData = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      //height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colours.lightRed,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(serviceData[
                                    'image_url'] ??
                                "https://i.pinimg.com/564x/b2/54/ea/b254ea1ec256b93c61aecb2aca62e277.jpg"),
                            radius: 40,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .05),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                serviceData['name'] ?? "client Name",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .055,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    serviceData['phone'] ?? "Phone Number",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.call),
                                ],
                              ),
                              Text(
                                serviceData['adress'] ?? "",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .050,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colours.red),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      FirebaseFirestore.instance
                                          .collection('DonorRegistration')
                                          .doc(serviceData[index].id)
                                          .delete();
                                    },
                                    child: const Text(
                                      "Decline",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
