// ignore_for_file: prefer_const_constructors

import 'package:bharatrail/business_logic/cubits/ChangeDateCubit/change_date_cubit.dart';
import 'package:bharatrail/business_logic/cubits/ExchangeCityCubit/exchange_city_cubit.dart';
import 'package:bharatrail/business_logic/cubits/TrainUpdatedCubit/train_updated_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ExchangeCityCubit()),
          BlocProvider(create: (context) => ChangeDateCubit()),
          BlocProvider(create: (context) => TrainUpdatedCubit())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: SplashScreen(theme: DarkTheme())));
  }
}
