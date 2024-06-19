import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/pain_and_palliative_page/add_palliative_details.dart';
import 'package:blood_donation/view/admin/screens/pagehome/pain_and_palliative_page/edit_palliative.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PainAndPalliativeAdmin extends StatelessWidget {
  const PainAndPalliativeAdmin({super.key});

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
                    builder: (context) => AddPalliativeDetails()),
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: constraints.maxHeight * 0.16,
                            width: MediaQuery.of(context).size.width * 0.95,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        data["name"] ?? "",
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxWidth * 0.06,
                                            overflow: TextOverflow.ellipsis),
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
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              data['phone'] ?? "",
                                              style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth *
                                                          0.04,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ],
                                        )),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            data['location'] ?? "",
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth * 0.04,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
