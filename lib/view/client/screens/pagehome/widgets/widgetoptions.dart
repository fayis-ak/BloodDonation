import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

class OptionsTile extends StatelessWidget {
  final String image;
  final String name;

  const OptionsTile({
    required this.image,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colours.lightRed),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 140, width: 140, child: Image.asset(image)),
          ),
          Text(
            name,
            style: Colours().tileText(),
          )
        ],
      ),
    );
  }
}
