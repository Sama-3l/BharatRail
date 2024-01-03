// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/business_logic/cubits/TrainUpdatedCubit/train_updated_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/data/repostitories/trains.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
import 'package:bharatrail/presentation/widgets/sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySelect extends StatefulWidget {
  CitySelect(
      {super.key,
      required this.theme,
      required this.allCities,
      required this.user});

  DarkTheme theme;
  Cities allCities;
  User user;

  @override
  State<CitySelect> createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  WidgetGenerator wg = WidgetGenerator();
  Trains trains = Trains();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.surfaceBlack,
      body: BlocBuilder<TrainUpdatedCubit, TrainUpdatedState>(
        builder: (context, state) {
          if (state is TrainUpdatedInitial) {
            return CustomScrollView(slivers: [
              SlAppBar(
                  theme: widget.theme,
                  cities: widget.allCities,
                  user: widget.user)
            ]);
          } else if (state is NotFoundState) {
            return CustomScrollView(slivers: [
              SlAppBar(
                  theme: widget.theme,
                  cities: widget.allCities,
                  user: widget.user),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Text("No Trains Found".toUpperCase(),
                        style: urbanist(widget.theme.labelWhite,
                            fontsize: fontSizeMedium, weight: FontWeight.w700)),
                  ),
                ),
              )
            ]);
          } else {
            return CustomScrollView(
                slivers: wg.generateTrainsList(context, widget.theme,
                    widget.allCities, widget.user, trains));
          }
        },
      ),
    );
  }
}
