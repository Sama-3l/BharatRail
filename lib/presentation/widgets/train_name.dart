// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class TrainName extends StatelessWidget {
  TrainName({super.key, required this.theme, required this.train});

  DarkTheme theme;
  Train train;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4),
          child:
              Text(train.name.toUpperCase(), style: urbanist(theme.labelWhite)),
        ),
        Text("(${train.number.toString()})",
            style: urbanist(theme.labelWhite, weight: FontWeight.w600)),
      ],
    );
  }
}
