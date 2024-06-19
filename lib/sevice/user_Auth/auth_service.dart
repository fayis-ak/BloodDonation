import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:blood_donation/view/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../constants/firebase_const.dart';
import '../../view/app1.dart';
import '../../view/splash_screen.dart';

class FireService {
  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection(admin)
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String obtainedEmail = querySnapshot.docs[0]['email'];
        if (obtainedEmail == email) {
          sign(email, password, 'AdminUser', context);
        }
      } else {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
            .collection(client)
            .where('email', isEqualTo: email)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          String obtainedEmail1 = querySnapshot.docs[0]['email'];
          if (obtainedEmail1 == email) {
            sign(email, password, 'ClientUser', context);
          }
        } else {
          QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
              .collection(super_admin)
              .where('email', isEqualTo: email)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            String obtainedEmail2 = querySnapshot.docs[0]['email'];
            if (obtainedEmail2 == email) {
              sign(email, password, 'SuperAdmin', context);
            }
          } else {
            Fluttertoast.showToast(msg: "User not found");
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong , Please try again");
    }
  }

  sign(String email, String password, String userType,
      BuildContext context) async {
    try {
      fire_auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null) {
          Fluttertoast.showToast(
              msg: "Login successfully",
              backgroundColor: Colors.white,
              textColor: Colors.black);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('email', email);
          prefs.setString('uid', value.user!.uid);
          prefs.setBool('isLoggedIn', true);
          prefs.setString('name', userType);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => Slpash_screen()),
              (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
              msg: "Incorrect Email or Password",
              backgroundColor: Colors.white,
              textColor: Colors.black);
        }
      });
    } on FirebaseAuthException catch (e) {
      List err = e.toString().split(']');
      Fluttertoast.showToast(
          msg: err[1].toString(),
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await fire_auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("The email address is already in use");
      } else {
        print("An error occurred: ${e.code}");
      }
    }
    return null;
  }

  // Future<User?> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     UserCredential credential = await fire_auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //
  //     return credential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found' || e.code == 'wrong-password') {
  //       print("Invalid email or password.");
  //     } else {
  //       print("An error occurred: ${e.code}");
  //     }
  //   }
  //   return null;
  // }

  Future save_user(String username, String email, String phone, String age,
      String blood, String uid, File? image) async {
    try {
      String clinett = "Client";
      String imageUrl = '';
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('client/$fileName.jpg');

        await reference.putFile(image);
        imageUrl = await reference.getDownloadURL();
      }
      await firestore.collection(client).add({
        "name": username,
        'email': email,
        'phone': phone,
        'blood': blood,
        'age': age,
        'userId': uid,
        "image_url": imageUrl,
        "role": clinett,
      });
    } catch (e) {
      print("errrrrroooorrr in save client");
    }
  }

  Future save_admin(
      String name, String email, String phone, String uid, File? image) async {
    try {
      String imageUrl = '';
      String role = "Admin";
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('admins/$fileName.jpg');

        await reference.putFile(image);
        imageUrl = await reference.getDownloadURL();
      }
      await firestore.collection(admin).add({
        "name": name,
        'email': email,
        'phone': phone,
        'userId': uid,
        'image_url': imageUrl,
        "role": role,
      });
    } catch (e) {
      print("save admin errrrrrooorrrrrrrrr");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUser(id) {
    return firestore
        .collection(client)
        .where("userId", isEqualTo: id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> adminInfo(id) {
    return firestore
        .collection(admin)
        .where('userId', isEqualTo: id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> Super_admin(id) {
    return firestore
        .collection(super_admin)
        .where('userId', isEqualTo: id)
        .snapshots();
  }

  Future blood_request(
      String blood,
      String name,
      String phone,
      String adress,
      String age,
      String date,
      String gender,
      String blooduint,
      uid,
      bool emergency) async {
    DocumentReference<Map<String, dynamic>> querySnapshot =
        await firestore.collection(bloodrequest).add({
      'name': name,
      'address': adress,
      'phone': phone,
      'gender': gender,
      'age': age,
      'blood': blood,
      'bloodUint': blooduint,
      'date': date,
      'uid': uid,
      'emergency': emergency,
    });
    String id = querySnapshot.id;
    await firestore.collection(bloodrequest).doc(id).update({'docId': id});
    // CollectionReference bloodreq = firestore.collection(bloodrequest);
    // bloodreq.add({
    //   'name': name,
    //   'address': adress,
    //   'phone': phone,
    //   'gender': gender,
    //   'age': age,
    //   'blood': blood,
    //   'bloodUint': blooduint,
    //   'date': date,
    //   'uid': uid,
    // });
  }

  Future<void> ambulance_serbi(
      String name, String number, String location, File? image) async {
    try {
      String imageUrl = '';
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('ambulance_images/$fileName.jpg');

        await reference.putFile(image);
        imageUrl = await reference.getDownloadURL();
      }

      await firestore.collection(Ambulance_service).add({
        'name': name,
        'number': number,
        'location': location,
        'image_url': imageUrl,
      });
    } catch (error) {
      print('Error storing ambulance service: $error');
      // Handle the error as needed
    }
  }

  Future<void> donorregistration(
    String name,
    String email,
    String number,
    String age,
    String blood,
    String weight,
    String adress,
    File? photo,
    String gender,
    String uid,
  ) async {
    try {
      String imageUrl = '';
      if (photo != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('donor_registration/$fileName.jpg');

        await reference.putFile(photo);
        imageUrl = await reference.getDownloadURL();
      }
      await firestore.collection(DonorRegistration).add({
        "name": name,
        "email": email,
        'phone': number,
        'age': age,
        'blood': blood,
        'weight': weight,
        'adress': adress,
        'image_url': imageUrl,
        'gender': gender,
        'termsAndConditionsAccepted': true,
        'uid': uid,
        'registration_date': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("donorregistration errrrror${e}");
    }
  }

  Future<void> palliative(
      String name, String number, String location, File? photo) async {
    try {
      String imageUrl = '';
      if (photo != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('Pain_Palliavtive/$fileName.jpg');

        await reference.putFile(photo);
        imageUrl = await reference.getDownloadURL();
      }
      firestore.collection(PainandPalliative).add({
        "name": name,
        "phone": number,
        'location': location,
        "image_url": imageUrl,
      });
    } catch (e) {
      print("palliative errrrror${e}");
    }
  }

  Future<void> nss_events(String title, String discreption, File? image) async {
    try {
      String image_url = '';
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final reference =
            fireabase_storage.ref().child('nssevent/$fileName.jpg');

        await reference.putFile(image);
        image_url = await reference.getDownloadURL();
      }

      DocumentReference<Map<String, dynamic>> querySnapshot =
          await firestore.collection(NssActivity).add({
        'title': title,
        'discreption': discreption,
        'image_url': image_url,
      });
      String id = querySnapshot.id;
      await firestore.collection(NssActivity).doc(id).update({'docId': id});
    } catch (error) {
      print('Error storing nss event: $error');
      // Handle the error as needed
    }
  }

  Future<void> hospital_add(
      String name, String number, String details, File? image) async {
    try {
      String image_url = '';
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final reference =
            fireabase_storage.ref().child('hospital/$fileName.jpg');

        await reference.putFile(image);
        image_url = await reference.getDownloadURL();
      }

      await firestore.collection(Hospitals).add({
        'name': name,
        'phone': number,
        'location': details,
        'photo': image_url
      });
    } catch (error) {
      print('Error storing nss event: $error');
      // Handle the error as needed
    }
  }

  static Future<String> donating(String uid) async {
    final querySnapshot = await firestore
        .collection('BloodRequest')
        .where("uid", isEqualTo: uid)
        .get();
    String userId = querySnapshot.docs.first.get('uid');
    return userId;
    //print("=========================$userId");
  }

//   Future blood_donating(
//     String name,
//     String phone,
//   ) async {
//     CollectionReference donating = firestore
//         .collection('client')
//         .doc("95esEv0QukCA3ghPgJTi")
//         .collection("blood donating");
//     donating.add({
//       'name': name,

//       'phone': phone,
//       // 'gender': gender,
//       // 'age': age,
//       // 'blood': blood,
//       // 'bloodUint': blooduint,
//       // 'date': date,
//       // 'uid': uid,
//     });
//   }
  // static Future<String?> getCurrentUserDetails(String uid) async {
  //   try {
  //     final querySnapshot = await firestore
  //         .collection('BloodRequest')
  //         .where("uid", isEqualTo: uid)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {

  //       final userData = querySnapshot.docs.first.data();
  //       return userData.toString();
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error getting user details: $e');
  //     return null;
  //   }
  // }
  Future<void> add_history(String name, String email, String whome,
      String hospital, String purpose, String date, File? image) async {
    try {
      String image_url = '';
      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final reference =
            fireabase_storage.ref().child('DonationHistory/$fileName.jpg');

        await reference.putFile(image);
        image_url = await reference.getDownloadURL();
      }
      await firestore.collection(DonationHistory).add({
        "name": name,
        "email": email,
        "personName": whome,
        "hospitalName": hospital,
        "purpose": purpose,
        "Donate_Date": date,
        'image_url': image_url,
        'Update_date': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("donorrHistroyyyyyyyyyyyyyy${e}");
    }
  }

  Future<User?> availabledonar(
      String email, String password, BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection(admin).where('uid', isEqualTo: "").get();
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong , Please try again");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getdonardetails(
      List<dynamic> donarid) {
    // log("=====================${donarid.toString()}");
    return FirebaseFirestore.instance
        .collection('DonorRegistration')
        .where('uid', whereIn: donarid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getBlooddetails(donarid) {
    return firestore
        .collection(bloodrequest)
        .where('uid', isEqualTo: donarid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> find_Acti(docid) {
    return firestore
        .collection(NssActivity)
        .where('docId', isEqualTo: docid)
        .snapshots();
  }

  Future<void> Add_history(String clientUid, List<dynamic> donorIds) async {
    CollectionReference history = firestore.collection('History');
    try {
      await history.add({
        "ClientID": clientUid,
        "DonerID": FieldValue.arrayUnion(donorIds),
        "Update_date": FieldValue.serverTimestamp(),
      });
      print("Document added successfully!");
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  static Future<void> updateUserProfileImage(
      String docID, String imageUrl) async {
    try {
      final userRef = firestore.collection(client).doc(docID);

      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        await userRef.update({
          'image_url': imageUrl,
        });
      } else {
        print('User document not found for userId: $docID');
      }

      print('User profile image updated successfully!');
    } catch (e) {
      print('Error updating user profile image: $e');
    }
  }

  static Future<void> upadteadminpropic(String docID, String imageUrl) async {
    try {
      final userRef = firestore.collection(admin).doc(docID);

      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        await userRef.update({
          'image_url': imageUrl,
        });
      } else {
        print('User document not found for userId: $docID');
      }

      print('User profile image updated successfully!');
    } catch (e) {
      print('Error updating user profile image: $e');
    }
  }

  static Future<bool> checkUser() async {
    final querySnapshot = await firestore
        .collection('BloodRequest')
        .where('uid', isEqualTo: fire_auth.currentUser!.uid)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

//static FirebaseMessaging fmessaging = FirebaseMessaging.instance;
}




//  static  checkUser() async {
//   await  firestore
//         .collection('BloodRequest')
//         .where('uid', isEqualTo: fire_auth.currentUser!.uid)
//         .get()
//         .then((value) {
//       if (value.docs.isNotEmpty) {
//         return true;
//       } else {
//         return false;
//       }
//     });
//   }
