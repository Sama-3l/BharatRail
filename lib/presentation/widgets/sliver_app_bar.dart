// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/business_logic/cubits/ExchangeCityCubit/exchange_city_cubit.dart';
import 'package:bharatrail/business_logic/cubits/TrainUpdatedCubit/train_updated_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/widgets/city_select_date_widget.dart';
import 'package:bharatrail/presentation/widgets/city_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class SlAppBar extends StatefulWidget {
  SlAppBar(
      {super.key,
      required this.theme,
      required this.cities,
      required this.user});

  DarkTheme theme;
  Cities cities;
  User user;

  @override
  State<SlAppBar> createState() => _SlAppBarState();
}

class _SlAppBarState extends State<SlAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:
              widget.theme.surfaceElevated), // Set the status bar color
      backgroundColor: Colors.transparent,
      toolbarHeight: MediaQuery.of(context).size.height * 0.52,
      floating: true,
      title: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.52,
          decoration: BoxDecoration(
              color: widget.theme.surfaceElevated,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32))),
          child: BlocBuilder<ExchangeCityCubit, ExchangeCityState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: setPadding(top: 24, bottom: 4),
                      child: Text("Departing Station",
                          style: urbanist(widget.theme.labelWhite))),
                  CitySelectBar(
                      theme: widget.theme,
                      cities: widget.cities,
                      user: widget.user,
                      depCity: true),
                  Container(
                      padding: setPadding(top: 16),
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            String temp = widget.user.depCity.name;
                            widget.user.depCity.name = widget.user.arrCity.name;
                            widget.user.arrCity.name = temp;
                            BlocProvider.of<ExchangeCityCubit>(context)
                                .onToggleButton();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.surfaceGrey2,
                              shape: CircleBorder()),
                          child: Padding(
                            padding: setPadding(),
                            child: Iconify(transfer, size: 24),
                          ))),
                  Padding(
                      padding: setPadding(bottom: 4),
                      child: Text("Arrival Station",
                          style: urbanist(widget.theme.labelWhite))),
                  CitySelectBar(
                      theme: widget.theme,
                      cities: widget.cities,
                      user: widget.user,
                      depCity: false),
                  CitySelectCalender(theme: widget.theme, user: widget.user),
                  Spacer(),
                  Container(
                    padding: setPadding(bottom: 16),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<TrainUpdatedCubit>(context).onTrainUpdated();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: widget.theme.uiBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      child: Text("LOAD TRAINS",
                          style: urbanist(widget.theme.labelWhite,
                              fontsize: 16, weight: FontWeight.w600)),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
