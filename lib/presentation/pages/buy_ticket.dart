// ignore_for_file: must_be_immutable

import 'package:bharatrail/business_logic/cubits/ClassUpdatedCubit/class_update_cubit_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicket extends StatefulWidget {
  BuyTicket({super.key, required this.user, required this.theme});

  DarkTheme theme;
  User user;

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  late Train train = widget.user.tickets[0].train;
  WidgetGenerator wg = WidgetGenerator();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.user.tickets.removeLast();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: widget.theme.surfaceBlack,
          body: BlocBuilder<ClassUpdateCubit, ClassUpdateState>(
            builder: (context, state) {
              return ListView(
                  children: wg.loadBuyTicketsListView(
                      widget.user, train, widget.theme));
            },
          ),
        ),
      ),
    );
  }
}
