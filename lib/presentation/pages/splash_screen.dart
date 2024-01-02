// ignore_for_file: must_be_immutable

import 'package:bharatrail/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, required this.theme});

  DarkTheme theme;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Functions().navigateToHome(context, widget.theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.surfaceBlack,
      body: const Center(
        child: Iconify(splashScreenLogo, size: 48)
      ),
    );
  }
}