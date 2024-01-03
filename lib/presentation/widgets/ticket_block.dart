import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class TicketGridItem extends StatelessWidget {
  TicketGridItem(
      {super.key,
      required this.index,
      required this.theme,
      required this.padding});

  final String index;
  final DarkTheme theme;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              border: Border.all(color: theme.surfaceGrey3, width: 2),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(index,
                style: urbanist(theme.labelWhite, fontsize: fontSizeLarge)),
          )),
    );
  }
}
