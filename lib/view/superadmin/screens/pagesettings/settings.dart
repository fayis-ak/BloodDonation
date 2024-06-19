import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/superadmin/screens/pagesettings/about.dart';
import 'package:blood_donation/view/superadmin/screens/pagesettings/privacy.dart';
import 'package:blood_donation/view/widgets/customalertbox.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/color.dart';
import '../../../../constants/firebase_const.dart';
import '../../../home/home_page.dart';

class SuperAdminSettingsPage extends StatelessWidget {
  const SuperAdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireService.Super_admin(fire_auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final user = snapshot.data?.docs.first;

            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            user?['image'] ?? "assets/images/profilepic.webp",
                          ),
                          radius: 70,
                        ),
                        Text(
                          user?['name'] ?? "name",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user?['email'] ?? "email",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        shareAppLink();
                      },
                      leading: const Icon(
                        Icons.share,
                        color: Colours.red,
                      ),
                      title: const Text("Invite Friends"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                      },
                      leading: const Icon(
                        Icons.privacy_tip_outlined,
                        color: Colours.red,
                      ),
                      title: const Text("Privacy Policy"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AboutUs()));
                      },
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colours.red,
                      ),
                      title: const Text("About"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Alert signout'),
                            content: const Text('Are you sure '),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                              ElevatedButton(
                                  onPressed: () async {
                                    Fluttertoast.showToast(
                                      msg: "logout succes",
                                    );

                                    clearSharedPreferences();
                                    await fire_auth.signOut().then(
                                        (value) => Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage(),
                                              ),
                                              (route) => false,
                                            ));
                                  },
                                  child: const Text('Yes'))
                            ],
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  void shareAppLink() {
    Share.share('https://yourapp.com', subject: 'Check out this app!');
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
