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
          "Blood instruction",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),

      body: SfPdfViewer.asset("assets/pdf/blood instructions.pdf"),
      //     body: SingleChildScrollView(
      //       padding: EdgeInsets.all(16.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Center(
      //             child: Image.asset(
      //               'images/blood 2.jpg', // Replace with your image asset
      //               height: 200,
      //               width: 200,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           SizedBox(height: 16),
      //           Text(
      //             'Thank you for considering blood donation!',
      //             style: TextStyle(
      //               fontSize: 24,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           SizedBox(height: 16),
      //           Text(
      //             'Here are some important instructions:',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           SizedBox(height: 16),
      //           _buildInstructionItem(
      //             'Eat a healthy meal before donation.',
      //           ),
      //
      //           _buildInstructionItem(
      //             'Get a good night\'s sleep before donating.',
      //           ),
      //           _buildInstructionItem(
      //             'Hydrate well before and after donation.',
      //           ),
      //           _buildInstructionItem(
      //             'Inform staff about any medications you are taking.',
      //           ),
      //           _buildInstructionItem(
      //             'Rest for a few minutes after donation.',
      //           ),
      //           SizedBox(height: 16),
      //           Text(
      //             'Remember, your donation can save lives!',
      //             style: TextStyle(
      //               color: Colors.red,
      //               fontSize: 18,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }
      //
      // Widget _buildInstructionItem(String instruction) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 8.0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Icon(Icons.check_circle, color: Colors.red, size: 30),
      //         SizedBox(width: 10),
      //         Expanded(
      //           child: Text(
      //             instruction,
      //             style: TextStyle(fontSize: 16),
      //           ),
      //         ),
      //       ],
      //     ),
    );
  }
}
