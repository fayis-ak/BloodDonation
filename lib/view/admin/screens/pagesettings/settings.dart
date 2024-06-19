import 'dart:io';

import 'package:blood_donation/constants/const%20img.dart';
import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/admin/bottomnav.dart';
import 'package:blood_donation/view/admin/screens/pagesettings/about_us.dart';
import 'package:blood_donation/view/admin/screens/pagesettings/privacy_policy.dart';
import 'package:blood_donation/view/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/color.dart';
import '../../../../constants/firebase_const.dart';
import '../../../widgets/bottomsheet.dart';
import '../../../widgets/pickimage.dart';
import '../pagehome/hompage.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _uploadImageToFirebase(docID) async {
    if (_imageFile == null) return;

    try {
      // final userId = fire_auth.currentUser?.uid;

      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$docID.jpg');
      await storageRef.putFile(_imageFile!);

      final imageUrl = await storageRef.getDownloadURL();

      await FireService.upadteadminpropic(docID, imageUrl);

      print(' updated successfully!');
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteFieldData(String docId) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(admin).doc(docId);

    String fieldToDelete = 'image_url';

    Map<String, dynamic> dataToDelete = {
      fieldToDelete: null,
    };

    await documentReference.update(dataToDelete);
    print('Field data deleted successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FireService.adminInfo(fire_auth.currentUser?.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = snapshot.data?.docs.first;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  Stack(children: [
                    CircleAvatar(
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : NetworkImage(user?["image_url"] ?? "")
                              as ImageProvider<Object>,
                      radius: 70,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            const Color.fromARGB(255, 173, 167, 167),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builderContext) {
                                  return BottomSheetModel(
                                    bottomsheetname: "profile photo",
                                    pickcamera: () async {
                                      final image = await ImagePickerHelperC
                                          .pickImageFromCamera();
                                      if (image != null) {
                                        setState(() {
                                          _imageFile = File(image.path);
                                          _uploadImageToFirebase(user!.id);
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    pickgallery: () async {
                                      final image1 = await ImagePickerHelperG
                                          .pickImageFromGallery();
                                      if (image1 != null) {
                                        setState(() {
                                          _imageFile = File(image1.path);
                                          _uploadImageToFirebase(user!.id);
                                        });
                                        Navigator.pop(context);
                                      }
                                      ;
                                    },
                                    handeldelete: () {
                                      setState(() {
                                        _imageFile = null;
                                        deleteFieldData(user!.id);
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          },
                          icon: const Icon(Icons.camera_alt_outlined,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ]),
                  Text(
                    user?['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .001,
                  ),
                  Text(
                    user?['email'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .001,
                  ),
                  Text(
                    user?['phone'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
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
                      title: const Text("invite friends"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyPolicy()));
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: Colours.red,
                        ),
                        title: Text("Privacy Policy"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUs()));
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colours.red,
                        ),
                        title: Text("About"),
                      ),
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
                                            (route) => false));
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
          }),
    );
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void shareAppLink() {
    Share.share('https://yourapp.com', subject: 'Check out this app!');
  }
}
