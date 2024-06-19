import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/firebase_const.dart';

class PainAndPalliative extends StatelessWidget {
  const PainAndPalliative({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Pain & Palliative",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: StreamBuilder(
        stream: firestore.collection(PainandPalliative).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var dataList = snapshot.data!.docs;
            return LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = dataList[index].data();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: constraints.maxHeight * 0.18,
                          width: constraints.maxWidth * 0.96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colours.lightRed,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data['image_url'] ??
                                      "https://bsmedia.business-standard.com/_media/bs/img/article/2023-02/17/full/20230217155512.jpg",
                                ),
                                radius: constraints.maxWidth * 0.1,
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      data["name"] ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth * 0.05,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: GestureDetector(
                                          onTap: () {
                                            final phone = data['phone'];
                                            if (phone != null) {
                                              ("tel:$phone");
                                            }

                                            launch("tel:${phone}");
                                          },
                                          child: Text(
                                            data['phone'] ?? "",
                                            style: TextStyle(
                                                //fontSize: constraints.maxWidth * 0.05,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          data['location'] ?? "",
                                          style: TextStyle(
                                              // fontSize:
                                              //     constraints.maxWidth * 0.04,
                                              overflow: TextOverflow.ellipsis),
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
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Loading state
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
