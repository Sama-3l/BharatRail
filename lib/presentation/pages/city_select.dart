// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/business_logic/cubits/TrainUpdatedCubit/train_updated_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/data/repostitories/trains.dart';
import 'package:bharatrail/functions/widgetGenerator.dart';
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
          return CustomScrollView(
              slivers: wg.generateTrainsList(context, widget.theme,
                  widget.allCities, widget.user, trains));
        },
      ),
    );
  }
}
