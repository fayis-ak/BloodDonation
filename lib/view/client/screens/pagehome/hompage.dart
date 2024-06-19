import 'dart:developer';

import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/client/screens/pagehome/widgets/widgetoptions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/options.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  void initState() {
    super.initState();
  }

  static Future<void> updatepushtoken(String? docId) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      log("Token: $token");

      FirebaseAuth auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(client)
            .doc(docId)
            .update({'push_token': token});
        log("user new token==============$token!");
      }
    } catch (e) {
      print("Error updating push token: $e");
    }
  }

  FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireService.getUser(fire_auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final user = snapshot.data?.docs.first;
          final docId = user?.id;
          updatepushtoken(docId);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Image.network(user?['image_url'] ?? ""),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user?['image_url'] ?? ""),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(capitalizeName(user?['name'])),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .020,
                vertical: MediaQuery.of(context).size.width * .020,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: firestore.collection('products').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return SizedBox();
                          }
                          var activityList = snapshot.data!.docs;
                          fMessaging.requestPermission();
                          return CarouselSlider.builder(
                            itemCount: activityList.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Container(
                              height: 180,
                              width: 350,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          activityList[itemIndex]["image_url"]),
                                      fit: BoxFit.fill),
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              // height: 190.0,
                              height: MediaQuery.of(context).size.width * .5,
                              autoPlay: true,
                              pageSnapping: true,
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tileList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        return FutureBuilder<bool>(
                          future: index == 8
                              ? FireService.checkUser()
                              : Future.value(true),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              final bool isVisible = snapshot.data ?? false;
                              return Visibility(
                                visible: isVisible,
                                child: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => optionScreen[index],
                                  )),
                                  child: OptionsTile(
                                    image: tileList[index].image,
                                    name: tileList[index].name,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

String capitalizeName(String? name) {
  if (name != null && name.isNotEmpty) {
    return name[0].toUpperCase() + name.substring(1);
  } else {
    return 'User';
  }
}
