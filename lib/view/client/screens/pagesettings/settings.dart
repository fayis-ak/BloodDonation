import 'dart:io';

import 'package:blood_donation/constants/color.dart';
import 'package:blood_donation/constants/firebase_const.dart';

import 'package:blood_donation/sevice/user_Auth/auth_service.dart';
import 'package:blood_donation/view/client/screens/pagesettings/settings/about.dart';
import 'package:blood_donation/view/client/screens/pagesettings/settings/privacy_policy.dart';
import 'package:blood_donation/view/home/home_page.dart';

import 'package:blood_donation/view/login_signUp/client_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/bottomsheet.dart';
import '../../../widgets/pickimage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final picker = ImagePicker();

  File? _imageFile;

  Future<void> getImage(id) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _uploadImageToFirebase(id);
      }
    });
  }

  Future<void> _uploadImageToFirebase(docID) async {
    if (_imageFile == null) return;

    try {
      // final userId = fire_auth.currentUser?.uid;

      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$docID.jpg');
      await storageRef.putFile(_imageFile!);

      final imageUrl = await storageRef.getDownloadURL();

      await FireService.updateUserProfileImage(docID, imageUrl);

      // print(' updated successfully!');
      Fluttertoast.showToast(
        msg: "updated successfully!",
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteFieldData(String docId) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(client).doc(docId);

    String fieldToDelete = 'image_url';

    Map<String, dynamic> dataToDelete = {
      fieldToDelete: null,
    };

    await documentReference.update(dataToDelete);
    // print('Field data deleted successfully');
    Fluttertoast.showToast(
      msg: "Field data deleted successfully",
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireService.getUser(fire_auth.currentUser?.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final user = snapshot.data?.docs.first;
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
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
                                          final image1 =
                                              await ImagePickerHelperG
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
                                    },);
                             
                             
                              },
                              icon: const Icon(Icons.camera_alt_outlined,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                      Text(
                        capitalizeName(
                          user?['name'],
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user?['email'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user?['phone'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
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
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy()),
                            );
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
                          onTap: () async {
                            _launchEmail('blooddonationadmin@gmail.com');
                          },
                          leading: const Icon(
                            Icons.message,
                            color: Colours.red,
                          ),
                          title: const Text("Help&Feedback"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const About()));
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
                                              (value) =>
                                                  Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ),
                                                (route) => false,
                                              ),
                                            );
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
                ),
              ),
            );
          }
        });
  }

  String capitalizeName(String? name) {
    if (name != null && name.isNotEmpty) {
      return name[0].toUpperCase() + name.substring(1);
    } else {
      return 'User';
    }
  }
}

void shareAppLink() {
  Share.share('https://yourapp.com', subject: 'Check out this app!');
}

Future<void> clearSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

_launchEmail(String email) async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );

  try {
    await launchUrl(_emailLaunchUri);
  } catch (e) {
    throw 'Could not launch email';
  }
}
