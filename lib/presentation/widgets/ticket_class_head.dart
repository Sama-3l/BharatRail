import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class TicketClassHeading extends StatelessWidget {
  const TicketClassHeading(
      {super.key, required this.seatNumber, required this.theme});

  final String seatNumber;
  final DarkTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: setPadding(bottom: 16, left: 0, right: 0),
      child: Text(seatNumber,
          style: urbanist(theme.labelWhite,
              fontsize: fontSizeHeadingMedium, weight: FontWeight.w100)),
    );
  }
}
