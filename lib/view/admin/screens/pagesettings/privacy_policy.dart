import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Privacy Policy"),
      ),
      body:SfPdfViewer.asset("assets/pdf/bloodprivacypolicy.pdf"),
    );
  }
}
