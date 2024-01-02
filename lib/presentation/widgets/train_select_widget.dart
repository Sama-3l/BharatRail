// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class CurrentTrainTile extends StatelessWidget {
  CurrentTrainTile({super.key, required this.train, required this.theme});

  DarkTheme theme;
  Train train;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
          color: theme.surfaceGrey3,
          padding: setPadding(top: 8, bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text(train.name.toUpperCase(), style: urbanist(theme.labelWhite)),
                ),
                Text("(${train.number.toString()})",
                    style: urbanist(theme.labelWhite, weight: FontWeight.w600)),
              ],
            )
          ])),
    ));
  }
}
