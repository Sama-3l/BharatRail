import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/widget_generator.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class PaymentCard extends StatelessWidget {
  PaymentCard(
      {super.key,
      required this.theme,
      required this.user,
      required this.train});

  final DarkTheme theme;
  final User user;
  final Train train;
  final WidgetGenerator wg = WidgetGenerator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: setPadding(left: 40, right: 40),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          decoration: BoxDecoration(
              color: theme.surfaceElevated,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: setPadding(top: 16, bottom: 24),
                child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Iconify(splashScreenLogo, size: 40),
                      Spacer()
                    ]),
              ),
              Container(
                  height: 3, width: double.infinity, color: theme.surfaceGrey3),
              Padding(
                  padding: setPadding(top: 16),
                  child: Text(user.name,
                      style: urbanist(theme.labelWhite,
                          fontsize: fontSizeLarge, weight: FontWeight.w200))),
              Padding(
                  padding: setPadding(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(train.name.toUpperCase(),
                          style: urbanist(theme.labelWhite,
                              fontsize: fontSizeMedium,
                              weight: FontWeight.w400)),
                      Text(train.number.toString(),
                          style: urbanist(theme.labelWhite,
                              fontsize: fontSizeMedium,
                              weight: FontWeight.w600)),
                    ],
                  )),
              Container(
                padding: setPadding(),
                height: MediaQuery.of(context).size.height * 0.41,
                child: ListView.builder(
                    itemCount: user.tickets.isNotEmpty
                        ? user.tickets.length
                        : 0, // Adjust the number of items as needed
                    itemBuilder: (context, index) {
                      return wg.checkWhetherSeatsPresent(
                          theme, user, train, index);
                    }),
              ),
              Expanded(
                child: Padding(
                  padding: setPadding(top: 8, bottom: 16),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.labelWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          child: Text("Complete Payment".toUpperCase(),
                              style: urbanist(theme.surfaceElevated,
                                  letterSpacing: 3, weight: FontWeight.w600)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
