import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/ticket.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/widget_generator.dart';
import 'package:flutter/material.dart';

class TicketsListTile extends StatelessWidget {
  TicketsListTile(
      {super.key,
      required this.user,
      required this.theme,
      required this.ticket,
      required this.train,
      required this.coachesWithTickets});

  final User user;
  final DarkTheme theme;
  final Ticket ticket;
  final Train train;
  final List<Coach> coachesWithTickets;
  final WidgetGenerator wg = WidgetGenerator();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: theme.surfaceGrey3,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: wg.renderPaymentTicketsCard(
                ticket, theme, train, coachesWithTickets),
          ),
        ));
  }
}
