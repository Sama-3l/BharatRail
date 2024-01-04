import 'package:bharatrail/assets/svgs/svg_code.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/presentation/widgets/payment_tickets_list_item.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard(
      {super.key,
      required this.theme,
      required this.user,
      required this.train});

  final DarkTheme theme;
  final User user;
  final Train train;

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
                      Iconify(backwardButton, size: 32),
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
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                    itemCount: user.tickets.isNotEmpty
                        ? user.tickets.length
                        : 0, // Adjust the number of items as needed
                    itemBuilder: (context, index) {
                      return TicketsListTile(
                          theme: theme,
                          ticket: user.tickets[index],
                          user: user,
                          train: train);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
