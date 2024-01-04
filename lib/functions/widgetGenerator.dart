import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/seats.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/data/repostitories/trains.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/widgets/buy_tickets_header.dart';
import 'package:bharatrail/presentation/widgets/city_select_date_widget.dart';
import 'package:bharatrail/presentation/widgets/select_coach_drop_down.dart';
import 'package:bharatrail/presentation/widgets/sliver_app_bar.dart';
import 'package:bharatrail/presentation/widgets/ticket_grid.dart';
import 'package:bharatrail/presentation/widgets/train_select_class.dart';
import 'package:bharatrail/presentation/widgets/train_select_widget.dart';
import 'package:bharatrail/presentation/widgets/train_time_bar.dart';
import 'package:flutter/material.dart';

class WidgetGenerator {
  // Generate the list of trains depending on the current arrival city and dep city stored in User (city_select.dart)
  List<Widget> generateTrainsList(BuildContext context, DarkTheme theme,
      Cities allCities, User user, Trains trains) {
    List<Widget> slivers = [];
    slivers.add(SlAppBar(theme: theme, cities: allCities, user: user));
    slivers.add(SliverToBoxAdapter(
        child: Padding(
      padding: setPadding(top: 8, bottom: 16),
      child: Text("TRAINS",
          style: urbanist(theme.labelWhite,
              fontsize: fontSizeHeading, weight: FontWeight.w600)),
    )));
    for (var train in trains.trains) {
      slivers.add(CurrentTrainTile(train: train, theme: theme, user: user));
    }
    return slivers;
  }

  // Check and render element such that user knows they already selected this city (city_select_widget.dart)
  Widget getDropDownItemText(
      City city, bool depCity, DarkTheme theme, User user) {
      if (depCity) {
        return Text(city.name,
            style: urbanist(user.arrCity.name != city.name
                ? theme.labelWhite
                : theme.labelWhite.withOpacity(0.5)));
      } else {
        return Text(city.name,
            style: urbanist(user.depCity.name != city.name
                ? theme.labelWhite
                : theme.labelWhite.withOpacity(0.5)));
      }
  }

  // Sets the font along with color depending on the type of tickets available ()
  Widget renderClassMetrics(List<int> metrics, DarkTheme theme) {
    if (metrics[0] != 0) {
      return Text("AVL ${metrics[0]}",
          style: urbanist(theme.surfaceGreen,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    } else if (metrics[1] != 0) {
      return Text("RAC ${metrics[1]}",
          style: urbanist(theme.uiYellow,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    } else {
      return Text("WL ${metrics[2]}",
          style: urbanist(theme.uiRed,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    }
  }

  // Children widgets for buy tickets page since I needed to
  // Add dynamic number of children to the listview
  // I had to create a seperate function for the same.
  // I haven't found a more efficient way to do this ()
  List<Widget> loadBuyTicketsListView(User user, Train train, DarkTheme theme) {
    List<Widget> children = [];
    children.add(BuyTicketsHeader(user: user, train: train, theme: theme));
    children.add(Padding(
      padding: setPadding(top: 8),
      child: TrainTimeBar(theme: theme, train: train, user: user),
    ));
    children.add(CitySelectCalender(
        theme: theme, user: user, transparentBackground: true));
    children.add(Padding(
      padding: setPadding(top: 8),
      child: SelectClass(
          train: train, theme: theme, user: user, buyTicketPage: true),
    ));

    children.add(Padding(
        padding: setPadding(top: 8),
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              user.tickets[0].seatClass,
              style: urbanist(theme.labelWhite,
                  fontsize: fontSizeLarge, weight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: renderClassMetrics(
                  train
                      .classes[allClasses.keys
                          .toList()
                          .indexOf(user.tickets[0].seatClass)]
                      .metrics,
                  theme),
            ),
          ],
        )));
    children.add(SelectCoachDropDownMenu(
        theme: theme,
        currClass: train.classes[
            allClasses.keys.toList().indexOf(user.tickets[0].seatClass)],
        ticket: user.tickets[0]));
    for (int i = 0;
        i <
            train
                .classes[
                    allClasses.keys.toList().indexOf(user.tickets[0].seatClass)]
                .coaches
                .length;
        i++) {
      children.add(TicketGrid(
          user: user,
          theme: theme,
          currCoach: train
              .classes[
                  allClasses.keys.toList().indexOf(user.tickets[0].seatClass)]
              .coaches[i],
          currClass: train
              .classes[
                  allClasses.keys.toList().indexOf(user.tickets[0].seatClass)],
          train: train));
    }

    return children;
  }

  // The grid is basically 4 rows with Column widgets. ()
  Widget loadSeatGrid(
      DarkTheme theme, User user, Seats seats, Coach currCoach) {
    List<Widget> children = [];
    for (int i = 0; i < seats.seats.length; i++) {
      if (seats.seats[i].isNotEmpty) {
        children.add(i == 2
            ? Padding(
                padding: setPadding(left: 0, right: 24),
                child: Column(children: seats.seats[i]))
            : Column(children: seats.seats[i]));
      }
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}
