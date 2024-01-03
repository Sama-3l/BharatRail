// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  ClassTile({super.key, required this.theme, required this.currClass});

  final DarkTheme theme;
  final Class currClass;
  WidgetGenerator wg = WidgetGenerator();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: setPadding(left: 8, top: 16, right: 8, bottom: 8),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: setPadding(left: 12, top: 4, bottom: 4),
            decoration: BoxDecoration(
                color: theme.surfaceGrey2,
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currClass.name.toUpperCase(),
                      style: urbanist(theme.labelWhite,
                          fontsize: 16, weight: FontWeight.w500)),
                  wg.renderClassMetrics(currClass.metrics, theme)
                ]),
          ),
        ));
  }
}