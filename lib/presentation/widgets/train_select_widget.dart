// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/widgets/train_name.dart';
import 'package:bharatrail/presentation/widgets/train_select_class.dart';
import 'package:bharatrail/presentation/widgets/train_time_bar.dart';
import 'package:flutter/material.dart';

class CurrentTrainTile extends StatelessWidget {
  CurrentTrainTile({super.key, required this.train, required this.theme, required this.user});

  DarkTheme theme;
  Train train;
  User user;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
          width: double.infinity,
          color: theme.surfaceGrey3,
          padding: setPadding(top: 8, bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TrainName(theme: theme, train: train),
            TrainTimeBar(theme: theme, train: train, user: user),
            SelectClass(train: train, theme: theme)
          ])),
    ));
  }
}
