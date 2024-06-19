import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../sevice/user_Auth/auth_service.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth fire_auth = FirebaseAuth.instance;
FirebaseStorage fireabase_storage = FirebaseStorage.instance;
const NssActivity ='NssActivity';
const client = "client";
const admin ="admin";
const super_admin ="superadmin";
const bloodrequest= "BloodRequest";
const Ambulance_service ='AmbulanceService';
const PainandPalliative = "PainandPalliative";
const Hospitals ='Hospitals';
const DonorRegistration = "DonorRegistration";
const DonationHistory ="DonationHistory";
const History ="History";
