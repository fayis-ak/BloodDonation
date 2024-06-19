import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

import 'donar_registration_home.dart';

class DonorRegistration extends StatefulWidget {
  const DonorRegistration({super.key});

  @override
  State<DonorRegistration> createState() => _DonorRegistrationState();
}

class _DonorRegistrationState extends State<DonorRegistration> {
  List<bool> isSelected = List.generate(3, (_) => false);

  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Terms and Conditions",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text(
                "Age Requirement:",
                style: Colours().tileStyle(),
              ),
              subtitle: const Text(
                  "Donors should typically be between the ages of 18 and 65."),
            ),
            ListTile(
              title: Text("Weight Requirement:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "Donors usually need to weigh at least 50 kg (110 lbs)"),
            ),
            ListTile(
              title: Text("Health Status:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "Donors must be in good health on the day of donation.Individuals with certain medical conditions or taking specific medications may be deferred from donating."),
            ),
            ListTile(
              title: Text("Travel History:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "Donors may be deferred based on recent travel history especially to regions with a high prevalence of infectious diseases"),
            ),
            ListTile(
              title: Text("High-Risk Behaviors:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "Individuals engaging in high-risk behaviors (intravenous drug use, multiple sexual partners, etc.) may be deferred."),
            ),
            ListTile(
              title: Text("Medical History:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "Donors are usually asked about their medical history to identify any conditions that might disqualify them from donating."),
            ),
            ListTile(
              title: Text("Pregnancy and Breastfeeding:",
                  style: Colours().tileStyle()),
              subtitle: const Text(
                  "Pregnant and breastfeeding individuals are typically deferred from blood donation."),
            ),
            ListTile(
              title:
                  Text("Frequency of Donation:", style: Colours().tileStyle()),
              subtitle: const Text(
                  "There are guidelines on how often a person can donate blood. For example, whole blood donation is often allowed every 8 to 12 weeks."),
            ),
            ListTile(
              title: Text("Testing for Infectious Diseases:",
                  style: Colours().tileStyle()),
              subtitle: const Text(
                  "Donated blood is tested for infectious diseases, including HIV, hepatitis B and C, syphilis, and others."),
            ),
            ListTile(
              title: Text("Iron Levels:", style: Colours().tileStyle()),
              subtitle: const Text(
                  " Donors' hemoglobin or iron levels are checked to ensure they are within the acceptable range."),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("I agree"),
                    checkColor: Colours.white,
                    selectedTileColor: Colours.white,
                    value: checkedValue,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = value!;
                      });
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.red,
                  fixedSize: const Size(370, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: checkedValue
                  ? () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Client_DonorRegistrationHome()));
                    }
                  : null,
              child: const Text(
                "Next",
                style: TextStyle(
                    color: Colours.white, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
