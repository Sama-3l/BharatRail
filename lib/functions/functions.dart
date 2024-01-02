// ignore_for_file: use_build_context_synchronously

import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/presentation/pages/city_select.dart';
import 'package:flutter/material.dart';

class Functions{

  // To simulate a splash screen, this leads the screen to the next page (splash_screen.dart)
  void navigateToHome(BuildContext context, Themes theme) async{
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CitySelect(theme: theme)));
  }
}