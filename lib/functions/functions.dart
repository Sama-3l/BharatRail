// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:bharatrail/business_logic/cubits/ChangeDateCubit/change_date_cubit.dart';
import 'package:bharatrail/business_logic/cubits/ClassUpdatedCubit/class_update_cubit_cubit.dart';
import 'package:bharatrail/business_logic/cubits/ExchangeCityCubit/exchange_city_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/seats.dart';
import 'package:bharatrail/data/models/ticket.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/pages/buy_ticket.dart';
import 'package:bharatrail/presentation/pages/city_select.dart';
import 'package:bharatrail/presentation/widgets/ticket_block.dart';
import 'package:bharatrail/presentation/widgets/ticket_class_head.dart';
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

  // Called when initializing Trains object (trains.dart)
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
          numberOfCompartmentsInBogey *
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
      randomSeatAllocation(classes.last);
    }
    return classes;
  }

  // 5 lines above us
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

  // SHOWS DATETIME PICKER (city_select_date_widget.dart)
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
                onSurface: theme.labelWhite, // body text color
                secondary: theme.labelWhite,
                onSecondary: theme.labelWhite, // header text color
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

  // Toggles on selection between default and toggle Value (train_class_tile.dart)
  dynamic toggleClassButton(User user, Class currClass, dynamic defaultDynamic,
      dynamic toggleDynamic) {
    return user.tickets.isEmpty
        ? defaultDynamic
        : currClass.name == user.tickets[0].seatClass
            ? toggleDynamic
            : defaultDynamic;
  }

  // On selecting class of Ticket (train_class_tile.dart)
  void onSelectingClass(Class currClass, Train train, bool buyTicketPage,
      User user, BuildContext context, DarkTheme theme) {
    Ticket newTicket = Ticket(
        seatClass: currClass.name,
        train: train,
        coach: train.classes
            .firstWhere((element) => currClass.name == element.name)
            .coaches[0]);
    if (buyTicketPage) {
      user.tickets.removeLast();
    }
    user.tickets.add(newTicket);
    BlocProvider.of<ClassUpdateCubit>(context).onClassChange();
    if (!buyTicketPage) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BuyTicket(user: user, theme: theme)));
    }
  }

  // Loads the seats correctly (ticket_grid.dart)
  Seats loadTicketLists(
      Seats seats, User user, DarkTheme theme, Coach currCoach) {
    seats.init(seats);
    List<bool> seatAvail = user.tickets[0].coach!.seats;
    int numberOfSeatsInOneRow = allClasses[user.tickets[0].seatClass]!;
    int p = 0;

    while (p < seatAvail.length) {
      int rowIndex = (p / numberOfSeatsInOneRow).floor();
      int seatIndex = p % numberOfSeatsInOneRow;
      if (numberOfSeatsInOneRow == 4) {
        if (rowIndex == 0) {
          seats.seats[seatIndex].add(TicketClassHeading(
              seatNumber: seatTypeIndex[seatIndex]!, theme: theme));
        }
        seats.seats[seatIndex].add(TicketGridItem(
            index: p,
            theme: theme,
            padding: ((p / numberOfSeatsInOneRow) % 2).floor() != 0 &&
                    rowIndex != (2 * numberOfCompartmentsInBogey - 1)
                ? setPadding(left: 8, right: 8, bottom: 48)
                : setPadding(left: 8, right: 8, bottom: 16),
            currCoach: currCoach));
      } else if (numberOfSeatsInOneRow < 4) {
        // Skips the middle berth for upper class tickets
        if (rowIndex == 0) {
          seats.seats[seatIndex < 1 ? seatIndex : (seatIndex) + 1].add(
              TicketClassHeading(
                  seatNumber: seatTypeIndex[
                      seatIndex < 1 ? seatIndex : (seatIndex) + 1]!,
                  theme: theme));
        }
        seats.seats[seatIndex < 1 ? seatIndex : (seatIndex) + 1].add(
            TicketGridItem(
                index: p,
                theme: theme,
                padding: checkCondition(
                    ((p / numberOfSeatsInOneRow) % 2).floor() != 0 &&
                        rowIndex != totalNumberOfRows - 1,
                    setPadding(left: 8, right: 8, bottom: 48),
                    setPadding(left: 8, right: 8, bottom: 16)),
                currCoach: currCoach));
      }
      p++;
    }
    return seats;
  }

  dynamic checkCondition(bool cond, dynamic defaultItem, dynamic toggleItem) {
    return cond ? defaultItem : toggleItem;
  }

  // Randomly Allocates whether a class should be
  // Avail, RAC or Waiting List                   (initiateClasses())
  void randomSeatAllocation(Class currClass) {
    double random = Random().nextDouble();
    if (random < 0.3) {
      setRAC(currClass);
    } else if (random < 0.6) {
      setWL(currClass);
    } else {
      setAvail(currClass);
    }
  }

  // Sets the class to be RAC (randomSeatAllocation())
  void setRAC(Class currClass) {
    int notAvail = 0;
    for (var coach in currClass.coaches) {
      notAvail += (coach.seats.length * 0.95).floor();
      coach.seats =
          selectAndSetTrue(coach.seats, (coach.seats.length * 0.95).floor());
    }
    currClass.metrics[1] =
        notAvail - currClass.metrics[0]; // Sets the number of RAC tickets
    currClass.metrics[0] = 0; // Sets Avail to 0
  }

  // Sets the class to be Waiting List (randomSeatAllocation())
  void setWL(Class currClass) {
    for (var coach in currClass.coaches) {
      coach.seats = coach.seats.map((x) => !x).toList();
    }
    currClass.metrics[0] = 0; // Sets Avail to 0
    currClass.metrics[1] = 0;
    currClass.metrics[2] = Random().nextInt(150);
  }

  // Sets the class to have available tickets (randomSeatAllocation())
  void setAvail(Class currClass) {
    int notAvail = 0;
    for (var coach in currClass.coaches) {
      int seatsBookedInCurrentCoach =
          Random().nextInt((coach.seats.length * 0.9).floor());
      notAvail += seatsBookedInCurrentCoach;
      coach.seats = selectAndSetTrue(coach.seats, seatsBookedInCurrentCoach);
    }
    currClass.metrics[0] = notAvail;
  }

  // Randomly selects n seats and set them to be booked
  List<bool> selectAndSetTrue(List<bool> boolList, int n) {
    if (n > boolList.length) {
      throw ArgumentError(
          "Invalid input: n must be less than or equal to the length of the bool list");
    }

    List<bool> result =
        List.from(boolList); // Create a copy of the original list

    Random random = Random();
    for (int i = 0; i < n; i++) {
      int randomIndex;
      do {
        randomIndex = random.nextInt(result.length);
      } while (result[
          randomIndex]); // Continue generating until a false value is found

      result[randomIndex] = true; // Set the selected index to true
    }

    return result;
  }
}
