import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class TrainGrid extends StatefulWidget {
  const TrainGrid({super.key, required this.user, required this.theme});

  final User user;
  final DarkTheme theme;

  @override
  State<TrainGrid> createState() => _TrainGridState();
}

class _TrainGridState extends State<TrainGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: setPadding(top: 24, bottom: 24),
      child: Container(
        decoration: BoxDecoration(
            color: widget.theme.surfaceElevated,
            borderRadius: BorderRadius.circular(32)),
        height: MediaQuery.of(context).size.height * 3,
        child: Container(),
      ),
    );
  }
}
