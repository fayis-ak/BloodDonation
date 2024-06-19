import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class BloodInstraction extends StatelessWidget {
  const BloodInstraction({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:  const Text("BloodInstraction",style: TextStyle(color: Colours.white),),
      backgroundColor: Colours.red,
       
    ),
     body: SfPdfViewer.asset("assets/pdf/blood instructions.pdf"),
    );
  }
}