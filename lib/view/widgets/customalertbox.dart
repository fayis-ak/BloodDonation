import 'package:blood_donation/constants/firebase_const.dart';
import 'package:blood_donation/view/home/home_page.dart';
import 'package:flutter/material.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget(
      {super.key, required this.title, required this.discreption});
  final String title;
  final String discreption;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title),
      content:  Text(discreption),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No')),
        ElevatedButton(
            onPressed: () async {
              await fire_auth
                  .signOut()
                  .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>HomePage(),
                  ),
                      (route) => false));
            },
            child: const Text('Yes'))
      ],
    );
  }
}