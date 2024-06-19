import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/user_request/user_accept_and_decline.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';

class UserRequestHome extends StatefulWidget {
  const UserRequestHome({super.key});

  @override
  State<UserRequestHome> createState() => _UserRequestHomeState();
}

class _UserRequestHomeState extends State<UserRequestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Requests",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: firestore.collection(client).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No donor requests found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var donorData = snapshot.data!.docs[index];
              return InkWell(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UserAcceptandDecline()),
                //   );
                // },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colours.red,
                    ),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenl,
                    textDirection: TextDirection.ltr,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .02,
                            top: MediaQuery.of(context).size.width * .02),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.height * .05,
                              backgroundImage: NetworkImage(
                                  donorData['image_url'] ??
                                      'default_image_url'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            donorData['name'],
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            donorData['age'],
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            donorData['blood'],
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            donorData['phone'],
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ],
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
