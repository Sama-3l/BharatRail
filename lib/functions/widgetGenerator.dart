import 'package:bharatrail/constants/colors.dart';
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
      padding: setPadding(top: 16),
      child: Text("TRAINS",
          style: urbanist(theme.labelWhite,
              fontsize: 32, weight: FontWeight.w600)),
    )));
    for (var train in trains.trains) {
      slivers.add(CurrentTrainTile(train: train, theme: theme));
    }
    return slivers;
  }
}
