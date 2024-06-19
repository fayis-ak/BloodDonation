import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Helpline extends StatelessWidget {
  const Helpline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Helpline",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colours.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("images/blood4.jpg"),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Welcome to the Help Line!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            // Text(
            //   'If you need assistance or have any questions, feel free to contact us:',
            //   style: TextStyle(fontSize: 20),
            // ),
            const SizedBox(height: 16),
            Column(
              children: [
                const SizedBox(width: 10),
                helpline(123654798, "Police"),
                const SizedBox(height: 16),
                helpline(1122336655, "FireForce"),
                const SizedBox(height: 16),
                helpline(121213652, "Hospital"),
              ],
            ),

            // Row(
            //   children: [
            //     const Icon(
            //       Icons.email,
            //       size: 30,
            //       color: Colors.red,
            //     ),
            //     const SizedBox(width: 10),
            //     GestureDetector(
            //       onTap: () {
            //         final email = "help@gmail.com";

            //         if (email != null) {
            //           launch("mailto:$email");
            //         }
            //       },
            //       child: const Text(
            //         "help@gmail.com" ?? "",
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  GestureDetector helpline(
    int number,
    String name,
  ) {
    return GestureDetector(
      onTap: () {
        final phone = number.toString();
        launch("tel:$phone");
      },
      child: Row(
        children: [
          Icon(
            Icons.phone,
            size: 30,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Text(
            "$name: $number",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}