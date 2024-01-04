import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/business_logic/cubits/ClassUpdatedCubit/class_update_cubit_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/ticket.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class SelectCoachDropDownMenu extends StatefulWidget {
  const SelectCoachDropDownMenu(
      {super.key,
      required this.theme,
      required this.currClass,
      required this.ticket,
      required this.controller});

  final DarkTheme theme;
  final Class currClass;
  final Ticket ticket;
  final ScrollController controller;

  @override
  State<SelectCoachDropDownMenu> createState() =>
      _SelectCoachDropDownMenuState();
}

class _SelectCoachDropDownMenuState extends State<SelectCoachDropDownMenu> {
  Functions func = Functions();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: setPadding(top: 16),
        child: Container(
          decoration: BoxDecoration(
              color: widget.theme.surfaceGrey2,
              borderRadius: BorderRadius.circular(8)),
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: setPadding(top: 8),
            child: DropdownButton(
              isExpanded: true,
              icon: const Iconify(dropDownButton, size: 24),
              underline: Container(),
              style: urbanist(widget.theme.labelWhite),
              dropdownColor: widget.theme.surfaceGrey2,
              value: widget.ticket.coach!.coachNumber,
              onChanged: (newValue) {
                func.onCoachChange(
                    widget.ticket,
                    widget.currClass,
                    newValue,
                    widget.controller,
                    MediaQuery.of(context).size.height * 2.11);
                BlocProvider.of<ClassUpdateCubit>(context).onClassChange();
              },
              items: widget.currClass.coaches.map((coach) {
                return DropdownMenuItem(
                    value: coach.coachNumber,
                    child: Text(coach.coachNumber,
                        style: urbanist(widget.theme.labelWhite,
                            fontsize: fontSizeLarge, weight: FontWeight.w800)));
              }).toList(),
            ),
          ),
        ));
  }
}
