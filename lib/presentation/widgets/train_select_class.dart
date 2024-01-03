import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/presentation/widgets/train_class_tile.dart';
import 'package:flutter/material.dart';

class SelectClass extends StatelessWidget {
  const SelectClass({super.key, required this.train, required this.theme});

  final Train train;
  final DarkTheme theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: train.classes.length,
            itemBuilder: (context, index) {
              return ClassTile(theme: theme, currClass: train.classes[index]);
            }));
  }
}
