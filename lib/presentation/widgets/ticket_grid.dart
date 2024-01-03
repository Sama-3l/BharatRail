// ignore_for_file: must_be_immutable

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/seats.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:flutter/material.dart';

class TicketGrid extends StatefulWidget {
  TicketGrid(
      {super.key,
      required this.user,
      required this.theme,
      required this.currCoach});

  DarkTheme theme;
  User user;
  Coach currCoach;

  @override
  State<TicketGrid> createState() => _TicketGridState();
}

class _TicketGridState extends State<TicketGrid> {
  Seats allSeats = Seats();
  Functions func = Functions();
  WidgetGenerator wg = WidgetGenerator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: setPadding(top: 24, bottom: 24),
      child: Container(
        decoration: BoxDecoration(
            color: widget.theme.surfaceElevated,
            borderRadius: BorderRadius.circular(32)),
        height: MediaQuery.of(context).size.height * 1.95,
        child: Container(
            padding: setPadding(top: 24, left: 0, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: setPadding(left: 24),
                  child: Text(widget.currCoach.coachNumber.toString(),
                      style: urbanist(widget.theme.labelWhite,
                          fontsize: fontSizeHeading, weight: FontWeight.w800)),
                ),
                Padding(
                  padding: setPadding(
                      top: 24),
                  child: wg.loadSeatGrid(
                      widget.theme,
                      widget.user,
                      func.loadTicketLists(allSeats, widget.user, widget.theme),
                      widget.currCoach),
                )
              ],
            )),
      ),
    );
  }
}
