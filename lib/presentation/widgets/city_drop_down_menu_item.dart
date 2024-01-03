import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:flutter/material.dart';

class CityDropDownMenuItem extends StatelessWidget {
  const CityDropDownMenuItem({super.key, required this.city, required this.theme});

  final City city;
  final DarkTheme theme;

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      value: city.name,
      child: Text(city.name, style: urbanist(theme.labelWhite)),
    );
  }
}
