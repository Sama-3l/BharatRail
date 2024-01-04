// ignore_for_file: must_be_immutable

import 'package:bharatrail/business_logic/cubits/ClassUpdatedCubit/class_update_cubit_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/seats.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/widget_generator.dart';
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
  late Train train = widget.user.tickets.last.train;
  WidgetGenerator wg = WidgetGenerator();
  ScrollController controller = ScrollController();
  Seats seats = Seats();
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seats.init(seats);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          return false;
        }
        widget.user.tickets.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: widget.theme.surfaceBlack,
          body: BlocBuilder<ClassUpdateCubit, ClassUpdateState>(
            builder: (context, sstate) {
              return ListView(
                  controller: controller,
                  children: wg.loadBuyTicketsListView(
                      widget.user, train, widget.theme, controller, seats));
            },
          ),
          floatingActionButton: ElevatedButton(
              onPressed: () {
                overlayEntry =
                    wg.showOverlay(context, widget.user, widget.theme, train);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.theme.labelWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              child: Padding(
                padding: setPadding(top: 16, bottom: 16, left: 0, right: 0),
                child: Text("Check Out".toUpperCase(),
                    style: urbanist(widget.theme.surfaceElevated,
                        fontsize: fontSizeMedium, weight: FontWeight.w600)),
              )),
        ),
      ),
    );
  }
}
