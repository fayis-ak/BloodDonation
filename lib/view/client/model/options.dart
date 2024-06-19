import 'package:blood_donation/constants/const%20img.dart';
import 'package:blood_donation/view/client/screens/pagehome/available_donar/available_donar.dart';

import '../screens/pagehome/ambulence_service_page/ambulence_service.dart';
import '../screens/pagehome/blood_instraction_page/blood_instraction.dart';
import '../screens/pagehome/blood_request_page/blood_request.dart';
import '../screens/pagehome/doner_registration_page/terms _and_conditions.dart';
import '../screens/pagehome/helpline/helpline_page.dart';
import '../screens/pagehome/hospitals/hospitals.dart';
import '../screens/pagehome/nss_activities_page/nss_activities.dart';
import '../screens/pagehome/pain_and_palliative_page/pain_and_palliative.dart';

class Options {
  late String name;

  late String image;

  Options({
    required this.name,
    required this.image,
  });
}

final List<Options> tileList = [
  Options(
    name: "DonorRegistration",
    image: "assets/Gridview/donar Registration.jpg",
  ),
  Options(
    name: "Blood Request",
    image: "assets/Gridview/user reques.png",
  ),
  Options(
    name: "Ambulance Service",
    image: "assets/Gridview/ambulancee.jpg",
  ),
  Options(
    name: "Pain and Palliative",
    image: "assets/Gridview/care.jpg",
  ),
  Options(
    name: "Hospitals",
    image: "assets/Gridview/hospital.png",
  ),
  Options(
    name: "Helpline",
    image: "assets/Gridview/helpline.png",
  ),
  Options(
    name: "Blood Instruction",
    image: "assets/Gridview/instructions.png",
  ),
  Options(
    name: "Nss Activities",
    image: "assets/Gridview/nss logo.jpg",
  ),
  Options(name: "Available Donar", image: "assets/Gridview/available2.jpg")
];

final List optionScreen = [
  const DonorRegistration(),
  const BloodRequest(),
  const ClientAmbulanceService(),
  const PainAndPalliative(),
  const client_hospital(),
  const Helpline(),
  const BloodInstraction(),
   Client_NssActivities(),
   AvailableDonors(),
];
