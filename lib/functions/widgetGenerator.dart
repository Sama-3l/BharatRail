import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/data/repostitories/trains.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/widgets/sliver_app_bar.dart';
import 'package:bharatrail/presentation/widgets/train_select_widget.dart';
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
              fontsize: 32, weight: FontWeight.w600)),
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

  Widget renderClassMetrics(List<int> metrics, DarkTheme theme) {
    if (metrics[0] != 0) {
      return Text("AVL ${metrics[0]}",
          style: urbanist(theme.surfaceGreen,
              fontsize: 16, weight: FontWeight.w500));
    } else if (metrics[1] != 0) {
      return Text("RAC ${metrics[1]}",
          style:
              urbanist(theme.uiYellow, fontsize: 16, weight: FontWeight.w500));
    } else {
      return Text("WL ${metrics[2]}",
          style: urbanist(theme.uiRed, fontsize: 16, weight: FontWeight.w500));
    }
  }
}
