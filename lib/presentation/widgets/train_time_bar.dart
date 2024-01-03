// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/presentation/widgets/train_time.dart';
import 'package:flutter/material.dart';

class TrainTimeBar extends StatelessWidget {
  TrainTimeBar(
      {super.key,
      required this.theme,
      required this.train,
      required this.user});

  DarkTheme theme;
  Train train;
  User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        TrainTime(
            theme: theme,
            time: train.citiesCovered.firstWhere((element) {
              return element.city.name == user.depCity.name;
            }).departure,
            dep: true),
        Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.55,
            color: theme.surfaceGrey1),
        TrainTime(
            theme: theme,
            time: train.citiesCovered.firstWhere((element) {
              return element.city.name == user.arrCity.name;
            }).arrival,
            dep: false),
      ]),
    );
  }
}
