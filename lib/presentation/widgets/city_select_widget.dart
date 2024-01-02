// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bharatrail/business_logic/cubits/ExchangeCityCubit/exchange_city_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySelectBar extends StatefulWidget {
  CitySelectBar(
      {super.key,
      required this.theme,
      required this.cities,
      required this.user,
      required this.depCity});

  DarkTheme theme;
  Cities cities;
  User user;
  bool depCity;

  @override
  State<CitySelectBar> createState() => _CitySelectBarState();
}

class _CitySelectBarState extends State<CitySelectBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: setPadding(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: widget.theme.surfaceGrey2,
              borderRadius: BorderRadius.circular(8)),
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: DropdownButton(
              hint: Text('Select a city'),
              icon: Container(),
              underline: Container(),
              style: urbanist(widget.theme.labelWhite),
              dropdownColor: widget.theme.surfaceGrey2,
              value: widget.depCity
                  ? widget.user.depCity.name
                  : widget.user.arrCity.name,
              onChanged: (newValue) {
                widget.depCity
                    ? widget.user.depCity.name = newValue!
                    : widget.user.arrCity.name = newValue!;
                BlocProvider.of<ExchangeCityCubit>(context).onToggleButton();
              },
              items: widget.cities.cities.map((city) {
                return DropdownMenuItem(
                  value: city.name,
                  child:
                      Text(city.name, style: urbanist(widget.theme.labelWhite)),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
