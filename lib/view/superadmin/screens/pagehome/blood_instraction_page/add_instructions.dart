import 'package:blood_donation/view/superadmin/screens/pagehome/blood_instraction_page/add_instructions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../constants/color.dart';

class BloodInstraction extends StatelessWidget {
  const BloodInstraction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "BloodInstruction",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: SfPdfViewer.asset("assets/pdf/blood instructions.pdf"),
    );
  }
}