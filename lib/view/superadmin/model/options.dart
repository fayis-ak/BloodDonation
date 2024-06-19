import 'package:blood_donation/view/superadmin/screens/pagehome/admin%20Registeration/admin_home.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/blood_request/donar_requiest_home.dart';
//import 'package:blood_donation/view/superadmin/screens/pagehome/donor_request/donar_requiest_home.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/donor_request_history/donor%20_request_history.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/find_donor/find_donar_home.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/recent_donation_history/recent_donation_history_home.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/user_request/user_request_homepage.dart';

import '../screens/pagehome/ambulence_service_page/ambulance_service.dart';
import '../screens/pagehome/blood_instraction_page/blood_instruction.dart';
import '../screens/pagehome/donor_registration_page/donor_terms _and_conditions.dart';
import '../screens/pagehome/helpline/helpline_page.dart';
import '../screens/pagehome/hospitals/hospitals.dart';
import '../screens/pagehome/nss_activities_page/nss_activities.dart';
import '../screens/pagehome/pain_and_palliative_page/pain_and_palliative.dart';
import '../screens/pagehome/recent_donation_history/donation_details.dart';

class SuperadminOptions {
  late String name;

  late String image;

  SuperadminOptions({
    required this.name,
    required this.image,
  });
}

final List<SuperadminOptions> tileList = [
  SuperadminOptions(
    name: "Admin Registration",
    image: "assets/Gridview/admin registration.png",
  ),
  SuperadminOptions(
    name: "User Request",
    image: "assets/Gridview/user reques.png",
  ),
  SuperadminOptions(
    name: "Recent Donation History",
    image: "assets/Gridview/donation history.jpg",
  ),
  SuperadminOptions(
    name: "Donor Registration",
    image: "assets/Gridview/donar Registration.jpg",
  ),
  SuperadminOptions(
    name: "Donor Request History",
    image: "assets/Gridview/donar req history.jpeg",
  ),
  SuperadminOptions(
    name: "Blood Request",
    image: "assets/Gridview/donar request.jpeg",
  ),
  SuperadminOptions(
    name: "Find Donor",
    image: "assets/Gridview/donarfind1.webp",
  ),
  SuperadminOptions(
    name: "Ambulance Service",
    image: "assets/Gridview/ambulancee.jpg",
  ),
  SuperadminOptions(
    name: "Pain and Palliative",
    image: "assets/Gridview/care.jpg",
  ),
  SuperadminOptions(
    name: "Hospitals",
    image: "assets/Gridview/hospital.png",
  ),
  SuperadminOptions(
    name: "Helpline",
    image: "assets/Gridview/helpline.png",
  ),
  SuperadminOptions(
    name: "Blood Instruction",
    image: "assets/Gridview/instructions.png",
  ),
  SuperadminOptions(
      name: "Nss Activities", image: "assets/Gridview/nss logo.jpg"),
];

final List SuperadminoptionScreen = [
  const AdminHome(),
  UserRequestHome(),
  Super_RecentDonationHistoryHome(),
  const DonorRegistration(),
   DonorRequestHistoryhome(),
  DonorRequestHome_super(),
  searchpage(),
  const AmbulanceService(),
  PainAndPalliative_super(),
  const Super_Hospitals(),
  const Helpline(),
  const BloodInstraction(),
  const NssActivty_super()
];
