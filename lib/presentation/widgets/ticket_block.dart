// ignore_for_file: must_be_immutable

import 'package:bharatrail/business_logic/cubits/cubit/ticket_selected_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketGridItem extends StatelessWidget {
  TicketGridItem(
      {super.key,
      required this.index,
      required this.theme,
      required this.padding,
      required this.currCoach});

  final int index;
  final DarkTheme theme;
  final EdgeInsets padding;
  Coach currCoach;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketSelectedCubit, TicketSelectedState>(
      builder: (context, state) {
        return Padding(
          padding: padding,
          child: GestureDetector(
            onTap: () {
              currCoach.seats[index] = !currCoach.seats[index];
              BlocProvider.of<TicketSelectedCubit>(context).onSelectingTicket();
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    color: currCoach.seats[index]
                        ? theme.labelWhite
                        : Colors.transparent,
                    border: Border.all(
                        color: currCoach.seats[index]
                            ? theme.labelWhite
                            : theme.surfaceGrey3,
                        width: 2),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text("${index + 1}",
                      style: urbanist(
                          currCoach.seats[index]
                              ? theme.surfaceElevated
                              : theme.labelWhite,
                          fontsize: fontSizeLarge)),
                )),
          ),
        );
      },
    );
  }
}
