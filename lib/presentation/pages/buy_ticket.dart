// ignore_for_file: must_be_immutable

import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/business_logic/cubits/ClassUpdatedCubit/class_update_cubit_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:bharatrail/presentation/widgets/city_select_date_widget.dart';
import 'package:bharatrail/presentation/widgets/select_coach_drop_down.dart';
import 'package:bharatrail/presentation/widgets/train_select_class.dart';
import 'package:bharatrail/presentation/widgets/train_time_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.theme.surfaceBlack,
        body: BlocBuilder<ClassUpdateCubit, ClassUpdateState>(
          builder: (context, state) {
            return ListView(children: [
              Container(
                  padding: setPadding(top: 24),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          widget.user.tickets.removeLast();
                          Navigator.of(context).pop();
                        },
                        child: const Iconify(backwardButton, size: 32)),
                    Row(children: [
                      Padding(
                        padding: setPadding(left: 4, right: 2),
                        child: Text(train.name.toUpperCase(),
                            style: urbanist(widget.theme.labelWhite,
                                fontsize: fontSizeLarge)),
                      ),
                      Text("(${train.number.toString()})",
                          style: urbanist(widget.theme.labelWhite,
                              fontsize: fontSizeLarge, weight: FontWeight.w600))
                    ]),
                  ])),
              Padding(
                padding: setPadding(top: 8),
                child: TrainTimeBar(
                    theme: widget.theme, train: train, user: widget.user),
              ),
              CitySelectCalender(
                  theme: widget.theme,
                  user: widget.user,
                  transparentBackground: true),
              Padding(
                padding: setPadding(top: 8),
                child: SelectClass(
                    train: train,
                    theme: widget.theme,
                    user: widget.user,
                    buyTicketPage: true),
              ),
              Padding(
                  padding: setPadding(top: 8),
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        widget.user.tickets[0].seatClass,
                        style: urbanist(widget.theme.labelWhite,
                            fontsize: fontSizeLarge, weight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: wg.renderClassMetrics(
                            train
                                .classes[allClasses.keys
                                    .toList()
                                    .indexOf(widget.user.tickets[0].seatClass)]
                                .metrics,
                            widget.theme),
                      ),
                    ],
                  )),
              SelectCoachDropDownMenu(
                  theme: widget.theme,
                  currClass: train.classes[allClasses.keys
                      .toList()
                      .indexOf(widget.user.tickets[0].seatClass)],
                  ticket: widget.user.tickets[0]),
                  
            ]);
          },
        ),
      ),
    );
  }
}
