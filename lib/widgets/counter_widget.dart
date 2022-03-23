import 'package:countup/countup.dart';
import 'package:covid_api_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final String title;
  final Color color;
  final int number;

  const Counter({
    Key? key,
    required this.title,
    required this.color,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(.26),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                    width: 2,
                  ),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: kSubTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Countup(
          begin: 0,
          end: number.toDouble(),
          duration: const Duration(seconds: 3),
          separator: ',',
          style: TextStyle(
            fontSize: 40,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
