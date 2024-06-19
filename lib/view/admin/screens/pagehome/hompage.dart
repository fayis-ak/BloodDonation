import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/admin/screens/pagehome/widgets/widgetoptions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../sevice/user_Auth/auth_service.dart';
import '../../model/options.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({
    super.key,
  });

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireService.adminInfo(fire_auth.currentUser?.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final user = snapshot.data?.docs.first;
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user?["image_url"] ??
                          ""),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(user?['name'] ?? "sdfghjk"),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: firestore.collection(NssActivity).snapshots(),
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
                            return CarouselSlider.builder(
                              itemCount: activityList.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Container(
                                height: 180,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            activityList[itemIndex]
                                                ["image_url"]??""),
                                        fit: BoxFit.fill)),
                              ),
                              options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  height: 190.0,
                                  autoPlay: true,
                                  pageSnapping: true),
                            );
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 12,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: 200),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminoptionScreen[index],
                            )),
                            child: OptionsTile(
                              image: tileList[index].image,
                              name: tileList[index].name,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
