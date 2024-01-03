// ignore_for_file: must_be_immutable

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class TicketGridItem extends StatelessWidget {
  TicketGridItem(
      {super.key,
      required this.index,
      required this.theme,
      required this.padding,
      required this.booked,
      required this.selected});

  final int index;
  final DarkTheme theme;
  final EdgeInsets padding;
  bool booked;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              border: Border.all(color: theme.surfaceGrey3, width: 2),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text("${index+1}",
                style: urbanist(theme.labelWhite, fontsize: fontSizeLarge)),
          )),
    );
  }
}
