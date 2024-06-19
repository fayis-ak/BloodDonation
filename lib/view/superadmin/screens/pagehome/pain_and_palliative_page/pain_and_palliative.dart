import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/pain_and_palliative_page/add_palliative_details.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/pain_and_palliative_page/edit_palliative.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/color.dart';

class PainAndPalliative_super extends StatelessWidget {
  PainAndPalliative_super({Key? key});

  // Mock stream for demonstration purposes
  // final Stream<List<String>> mockDataStream = Stream.value(['Item 1', 'Item 2', 'Item 3']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "PainAndPalliative",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPalliativeDetails_super()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colours.white,
            ),
          )
        ],
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
                      child: InkWell(
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
                                        .collection(PainandPalliative)
                                        .doc(dataList[index].id)
                                        .delete();
                                  },
                                  child: const Text("Yes"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: constraints.maxHeight * 0.16,
                          width: constraints.maxWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colours.lightRed,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.09,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data['image_url'] ??
                                      "https://bsmedia.business-standard.com/_media/bs/img/article/2023-02/17/full/20230217155512.jpg",
                                ),
                                radius: constraints.maxWidth * 0.1,
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data["name"] ?? "",
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.05,
                                    ),
                                  ),
                                  GestureDetector(
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
                                          // fontSize: constraints.maxWidth * 0.05,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    data['location'] ?? "",
                                    style: TextStyle(
                                        // fontSize: constraints.maxWidth * 0.05,
                                        ),
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
