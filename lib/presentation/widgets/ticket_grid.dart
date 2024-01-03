import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:flutter/material.dart';

class TicketGrid extends StatefulWidget {
  TicketGrid({super.key, required this.user, required this.theme});

  DarkTheme theme;
  User user;

  @override
  State<TicketGrid> createState() => _TicketGridState();
}

class _TicketGridState extends State<TicketGrid> {
  List<Widget> lowerSeats = [];
  List<Widget> middleSeats = [];
  List<Widget> upperSeats = [];
  List<Widget> sideSeats = [];


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}