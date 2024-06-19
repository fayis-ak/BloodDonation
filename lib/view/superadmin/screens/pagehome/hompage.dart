import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/widgets/widgetoptions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../sevice/user_Auth/auth_service.dart';
import '../../model/options.dart';

class SuperAdminHomePage extends StatelessWidget {
  const SuperAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireService.Super_admin(fire_auth.currentUser?.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.none ||
              !snapshot.hasData) {
            return Text("nodata");
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("User data not found"));
          } else {
            final user = snapshot.data!.docs.first;
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user?["image"]),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                    Text(user?["name"] ?? "User Name Not Found"),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              itemBuilder:
                                  (BuildContext context, int itemIndex,
                                          int pageViewIndex) =>
                                      StreamBuilder(
                                          stream: null,
                                          builder: (context, snapshot) {
                                            return Container(
                                              height: 180,
                                              width: 350,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        activityList[itemIndex]
                                                                ["image_url"] ??
                                                            AssetImage(
                                                                "assets/imagepicker/unnamed.png")),
                                                    fit: BoxFit.fill),
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                            );
                                          }),
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                height: 190.0,
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
                        itemCount: 13,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 200,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SuperadminoptionScreen[index],
                            )),
                            child: OptionsTile(
                              image: tileList[index].image,
                              name: tileList[index].name,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
