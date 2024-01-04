// ignore_for_file: must_be_immutable

import 'package:bharatrail/business_logic/cubits/cubit/ticket_selected_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketGridItem extends StatelessWidget {
  TicketGridItem(
      {super.key,
      required this.index,
      required this.theme,
      required this.padding,
      required this.currCoach,
      required this.user,
      required this.train,
      required this.currClass});

  final int index;
  final DarkTheme theme;
  final EdgeInsets padding;
  Coach currCoach;
  Class currClass;
  Train train;
  User user;
  Functions func = Functions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketSelectedCubit, TicketSelectedState>(
      builder: (context, state) {
        return Padding(
          padding: padding,
          child: GestureDetector(
            onTap: () {
              func.onSeatSelection(currCoach, index, user, currClass, train);
              BlocProvider.of<TicketSelectedCubit>(context).onSelectingTicket();
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    color: currCoach.seats[0][index]
                        ? theme.surfaceElevated
                        : currCoach.seats[1][index]
                            ? theme.labelWhite
                            : theme.surfaceElevated,
                    border: Border.all(
                        color: currCoach.seats[0][index]
                            ? theme.surfaceGrey3
                            : currCoach.seats[1][index]
                                ? theme.surfaceGrey3
                                : theme.labelWhite,
                        width:  currCoach.seats[0][index]
                            ? 2
                            : currCoach.seats[1][index]
                                ? 4
                                : 2),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text("${index + 1}",
                      style: urbanist(
                          currCoach.seats[0][index]
                              ? theme.surfaceGrey3
                              : currCoach.seats[1][index]
                                  ? theme.surfaceGrey3
                                  : theme.labelWhite,
                          fontsize: fontSizeLarge)),
                )),
          ),
        );
      },
    );
  }
}
