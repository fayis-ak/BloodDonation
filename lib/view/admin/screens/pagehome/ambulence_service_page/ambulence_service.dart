import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/ambulence_service_page/add%20ambulence%20service.dart';
import 'package:blood_donation/view/admin/screens/pagehome/ambulence_service_page/edit_ambulance.dart';
import 'package:flutter/material.dart';

class Admin_AmbulenceService extends StatelessWidget {
  const Admin_AmbulenceService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "AmbulenceService",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: StreamBuilder(
        stream: firestore.collection(Ambulance_service).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No ambulance services found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var serviceData = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .16,
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
                            width: MediaQuery.of(context).size.width * .05),
                        CircleAvatar(
                          backgroundImage: NetworkImage(serviceData[
                                  'image_url'] ??
                              "https://i.pinimg.com/564x/b2/54/ea/b254ea1ec256b93c61aecb2aca62e277.jpg"),
                          radius: 40,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .06),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceData['name'] ?? "Service Name",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              serviceData['number'] ?? "Phone Number",
                              // style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              serviceData['location'] ?? "Location",
                              //style: TextStyle(fontSize: 16),
                            ),
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
      ),
    );
  }
}
