import 'package:covid_api_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

class DetailButton extends StatelessWidget {
  final String text;
  const DetailButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
