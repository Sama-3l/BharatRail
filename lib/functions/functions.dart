// ignore_for_file: use_build_context_synchronously

import 'package:bharatrail/business_logic/cubits/ChangeDateCubit/change_date_cubit.dart';
import 'package:bharatrail/business_logic/cubits/ExchangeCityCubit/exchange_city_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/coach.dart';
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
        arrCity: City(name: "Chennai"),
        depCity: City(name: "New Delhi"),
        depTime: DateTime.now());
  }

  List<Class> initiateClasses() {
    List<Class> classes = [];
    for (var thisClass in allClasses.entries) {
      int numberOfCoachesInThisClass =
          int.parse(keyForClass[thisClass.key]![1]);

      // Number of seats on one side * 2 = Number of seats in a bogey(For example 8 in 3A)
      // Number of seats on one side * 2 * 9 = Number of seats in one coach(72 seats in B1 of 3rd AC)
      // Number of seats on one side * 2 * 9 * Number of total coaches in class = 432 seats in 3rd AC from B1 to B6)
      int numberOfSeats = thisClass.value *
          2 *
          9 *
          numberOfCoachesInThisClass; // This calculates how much seats each class has

      classes.add(Class(
          name: thisClass.key,
          dimensionOfClass: thisClass.value,
          metrics: [
            (0.9 * numberOfSeats).floor(), // AVAILABLE
            (0.1 * numberOfSeats)
                .floor(), // RAC - (AVAIL IS FINISHED THEN ALL THE SEATS LEFT ARE RAC)
            0 // WL - (This increases when AVAIL AND RAC ARE FINISHED)
          ],
          coaches: initiateCoaches(thisClass.key, thisClass.value)));
    }
    return classes;
  }

  List<Coach> initiateCoaches(String thisClass, int dim) {
    List<Coach> coaches = [];
    int numberOfCoaches = int.parse(keyForClass[thisClass]![1]);
    for (int i = 1; i <= numberOfCoaches; i++) {
      coaches.add(Coach(
          coachNumber:
              "${keyForClass[thisClass]?[0]}$i", // Creates Coach with coach name B1, E2, S12, etc.
          seats: List.filled(dim * 2 * 9, false))); // Creates a list of
    }
    return coaches;
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

  // OnChanged of DropDownMenus (city_select_widget.dart)
  void onCitySelection(
      BuildContext context, User user, String? newValue, bool depCity) {
    // Checks if the code is supposed to change the departing or arrival city
    // Then checks if the user is trying to set both the cities as same and avoids that
    if (depCity) {
      if (user.arrCity.name != newValue) {
        user.depCity.name = newValue!;
      }
    } else {
      if (user.depCity.name != newValue) {
        user.arrCity.name = newValue!;
      }
    }
    BlocProvider.of<ExchangeCityCubit>(context).onToggleButton();
  }
}
