// ignore_for_file: must_be_immutable

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainTime extends StatefulWidget {
  TrainTime({super.key, required this.theme, required this.time, required this.dep});

  DarkTheme theme;
  DateTime time;
  bool dep;

  @override
  State<TrainTime> createState() => _TrainTimeState();
}

class _TrainTimeState extends State<TrainTime> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: widget.dep ? CrossAxisAlignment.start : CrossAxisAlignment.end, children: [
      Text(DateFormat('HH:mm').format(widget.time),
          style: urbanist(widget.theme.labelWhite,
              fontsize: fontSizeLarge, weight: FontWeight.w500)),
      Text(DateFormat('MMM dd, yy').format(widget.time),
          style: urbanist(widget.theme.labelWhite,
              fontsize: fontSizeSmall, weight: FontWeight.w800))
    ]);
  }
}
