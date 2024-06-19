import 'package:blood_donation/constants/const%20img.dart';
import 'package:blood_donation/view/admin/screens/pagehome/ambulence_service_page/ambulence_service.dart';
import 'package:blood_donation/view/admin/screens/pagehome/blood_instraction_page/blood_instraction.dart';
import 'package:blood_donation/view/admin/screens/pagehome/doner_registration_page/donor_terms _and_conditions.dart';
import 'package:blood_donation/view/admin/screens/pagehome/donor_request/donar_request_home.dart';
import 'package:blood_donation/view/admin/screens/pagehome/donor_request_history/donor%20_request_history.dart';
import 'package:blood_donation/view/admin/screens/pagehome/find_donor/find_donar_home.dart';
import 'package:blood_donation/view/admin/screens/pagehome/helpline/helpline_page.dart';
import 'package:blood_donation/view/admin/screens/pagehome/hospitals/hospitals.dart';
import 'package:blood_donation/view/admin/screens/pagehome/nss_activities_page/nss_activities.dart';
import 'package:blood_donation/view/admin/screens/pagehome/recent_donation_history/recent_donation_history_home.dart';
import 'package:blood_donation/view/admin/screens/pagehome/user_request/user_request_homepage.dart';
import 'package:blood_donation/view/superadmin/screens/pagehome/pain_and_palliative_page/pain_and_palliative.dart';

import '../../superadmin/screens/pagehome/recent_donation_history/donation_details.dart';

class AdminOptions {
  late String name;

  late String image;

  AdminOptions({
    required this.name,
    required this.image,
  });
}

final List<AdminOptions> tileList = [
  AdminOptions(name: "User Request", image: Gridview_user_request),
  AdminOptions(
    name: "Recent Donation History",
    image: Gridview_recent_donation_history,
  ),
  AdminOptions(
    name: "Donor Registration",
    image: Gridview_donor_registration,
  ),
  AdminOptions(
    name: "Donor Request History",
    image: Gridview_donor_request_history,
  ),
  AdminOptions(
    name: "Donor Request",
    image: Gridview_donor_request,
  ),
  AdminOptions(
    name: "Find Donor",
    image: Gridview_find_donor,
  ),
  AdminOptions(
    name: "Ambulance Service",
    image: Gridview_ambulance_service,
  ),
  AdminOptions(
    name: "Pain and Palliative",
    image: Gridview_painandpallative,
  ),
  AdminOptions(
    name: "Hospitals",
    image: Gridview_hospitals,
  ),
  AdminOptions(
    name: "Helpline",
    image: Gridview_helpline,
  ),
  AdminOptions(
    name: "Blood Instruction",
    image: Gridview_blood_instruction,
  ),
  AdminOptions(
    name: "Nss Activities",
    image: Gridview_nss_activities,
  ),
];

final List AdminoptionScreen = [
  const UserRequestHome(),
  const Super_RecentDonationHistoryHome(),
//  const RecentDonationHistoryHome(),
  const DonorRegistration(),
  Admin_DonorRequestHistoryhome(),
  const DonorRequestHome(),
  FindDonarHome(),
  const Admin_AmbulenceService(),
  PainAndPalliative_super(),
  const admin_Hospitals(),
  const Helpline(),
  const BloodInstraction(),
  const NssActivities()
];
