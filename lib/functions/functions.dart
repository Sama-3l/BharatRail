// ignore_for_file: use_build_context_synchronously

import 'package:bharatrail/business_logic/cubits/cubit/change_date_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/presentation/pages/city_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Functions {
  // To simulate a splash screen, this leads the screen to the next page (splash_screen.dart)
  void navigateToHome(BuildContext context, DarkTheme theme) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CitySelect(
                theme: theme,
                allCities: Cities().initiateCities(),
                user: initializeUser())));
  }

  // Initalizes user generally supposed to work on backend call
  User initializeUser() {
    return User(
        name: "Samael",
        arrCity: City(name: "New Delhi"),
        depCity: City(name: "Lucknow"),
        depTime: DateTime.now());
  }

  Future<void> selectDate(
      BuildContext context, User user, DarkTheme theme) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: user.depTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: theme.surfaceElevated,
              colorScheme: ColorScheme.light(
                primary: theme.surfaceGrey3, // header background color
                onPrimary: theme.labelWhite, // header text color
                onSurface: theme.labelWhite, // body text color
              ),
              textTheme: TextTheme(
                headlineMedium:
                    TextStyle(color: theme.labelWhite), // Other text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: theme.uiBlue, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != user.depTime) {
      user.depTime = picked;
      BlocProvider.of<ChangeDateCubit>(context).onChangeDate();
    }
  }
}
