// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  ClassTile(
      {super.key,
      required this.theme,
      required this.currClass,
      required this.train,
      required this.user,
      required this.buyTicketPage});

  final DarkTheme theme;
  final Class currClass;
  final Train train;
  final User user;
  final Functions func = Functions();
  final WidgetGenerator wg = WidgetGenerator();
  final bool buyTicketPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: setPadding(left: 8, top: 16, right: 8, bottom: 8),
        child: GestureDetector(
          onTap: () => func.onSelectingClass(
              currClass, train, buyTicketPage, user, context, theme),
          child: Container(
            padding: setPadding(left: 12, top: 4, bottom: 4),
            decoration: BoxDecoration(
                color: func.toggleClassButton(
                    user, currClass, theme.surfaceGrey2, theme.labelWhite),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currClass.name.toUpperCase(),
                      style: func.toggleClassButton(
                          user,
                          currClass,
                          urbanist(theme.labelWhite,
                              fontsize: fontSizeMedium,
                              weight: FontWeight.w600),
                          urbanist(theme.surfaceBlack,
                              fontsize: fontSizeLarge,
                              weight: FontWeight.w600))),
                  func.toggleClassButton(
                      user,
                      currClass,
                      wg.renderClassMetrics(currClass.metrics, theme),
                      Container())
                ]),
          ),
        ));
  }
}
