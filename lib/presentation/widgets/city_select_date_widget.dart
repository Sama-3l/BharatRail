// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/business_logic/cubits/cubit/change_date_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';

class CitySelectCalender extends StatelessWidget {
  CitySelectCalender({super.key, required this.theme, required this.user});

  DarkTheme theme;
  User user;
  Functions func = Functions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeDateCubit, ChangeDateState>(
      builder: (context, state) {
        return Padding(
            padding: setPadding(top: 16),
            child: GestureDetector(
              onTap: () {
                func.selectDate(context, user, theme);
              },
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: theme.surfaceGrey2,
                      borderRadius: BorderRadius.circular(8)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    children: [
                      Padding(
                        padding: setPadding(left: 8, right: 16),
                        child: Iconify(calender),
                      ),
                      Text(DateFormat('EE, MMMM d, y').format(user.depTime),
                          style: urbanist(theme.labelWhite)),
                    ],
                  )),
            ));
      },
    );
  }
}
