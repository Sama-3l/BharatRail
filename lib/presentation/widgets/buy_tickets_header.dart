import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class BuyTicketsHeader extends StatelessWidget {
  BuyTicketsHeader(
      {super.key,
      required this.user,
      required this.train,
      required this.theme});

  final User user;
  final Train train;
  final DarkTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: setPadding(top: 24),
        child: Row(children: [
          GestureDetector(
              onTap: () {
                user.tickets.removeLast();
                Navigator.of(context).pop();
              },
              child: const Iconify(backwardButton, size: 32)),
          Row(children: [
            Padding(
              padding: setPadding(left: 4, right: 2),
              child: Text(train.name.toUpperCase(),
                  style: urbanist(theme.labelWhite, fontsize: fontSizeLarge)),
            ),
            Text("(${train.number.toString()})",
                style: urbanist(theme.labelWhite,
                    fontsize: fontSizeLarge, weight: FontWeight.w600))
          ]),
        ]));
  }
}
