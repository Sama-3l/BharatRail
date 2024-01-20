import 'package:bharatrail/business_logic/cubits/TicketSelectedCubit/ticket_selected_cubit.dart';
import 'package:bharatrail/constants/colors.dart';
import 'package:bharatrail/constants/constants.dart';
import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/seats.dart';
import 'package:bharatrail/data/models/ticket.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/user.dart';
import 'package:bharatrail/data/repostitories/cities.dart';
import 'package:bharatrail/data/repostitories/trains.dart';
import 'package:bharatrail/functions/const_functions.dart';
import 'package:bharatrail/functions/functions.dart';
import 'package:bharatrail/presentation/widgets/buy_tickets_header.dart';
import 'package:bharatrail/presentation/widgets/city_select_date_widget.dart';
import 'package:bharatrail/presentation/widgets/payment_card.dart';
import 'package:bharatrail/presentation/widgets/payment_tickets_list_item.dart';
import 'package:bharatrail/presentation/widgets/select_coach_drop_down.dart';
import 'package:bharatrail/presentation/widgets/sliver_app_bar.dart';
import 'package:bharatrail/presentation/widgets/ticket_grid.dart';
import 'package:bharatrail/presentation/widgets/train_select_class.dart';
import 'package:bharatrail/presentation/widgets/train_select_widget.dart';
import 'package:bharatrail/presentation/widgets/train_time_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetGenerator {
  // Generate the list of trains depending on the current arrival city and dep city stored in User (city_select.dart)
  List<Widget> generateTrainsList(BuildContext context, DarkTheme theme,
      Cities allCities, User user, Trains trains) {
    List<Widget> slivers = [];
    slivers.add(SlAppBar(theme: theme, cities: allCities, user: user));
    slivers.add(SliverToBoxAdapter(
        child: Padding(
      padding: setPadding(top: 8, bottom: 16),
      child: Text("TRAINS",
          style: urbanist(theme.labelWhite,
              fontsize: fontSizeHeading, weight: FontWeight.w600)),
    )));
    for (var train in trains.trains) {
      slivers.add(CurrentTrainTile(train: train, theme: theme, user: user));
    }
    return slivers;
  }

  // Check and render element such that user knows they already selected this city (city_select_widget.dart)
  Widget getDropDownItemText(
      City city, bool depCity, DarkTheme theme, User user) {
    if (depCity) {
      return Text(city.name,
          style: urbanist(user.arrCity.name != city.name
              ? theme.labelWhite
              : theme.labelWhite.withOpacity(0.5)));
    } else {
      return Text(city.name,
          style: urbanist(user.depCity.name != city.name
              ? theme.labelWhite
              : theme.labelWhite.withOpacity(0.5)));
    }
  }

  // Sets the font along with color depending on the type of tickets available 
  // (train_class_tile.dart)
  Widget renderClassMetrics(List<int> metrics, DarkTheme theme) {
    if (metrics[0] != 0) {
      return Text("AVL ${metrics[0]}",
          style: urbanist(theme.surfaceGreen,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    } else if (metrics[1] != 0) {
      return Text("RAC ${metrics[1]}",
          style: urbanist(theme.uiYellow,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    } else {
      return Text("WL ${metrics[2]}",
          style: urbanist(theme.uiRed,
              fontsize: fontSizeMedium, weight: FontWeight.w500));
    }
  }

  // Children widgets for buy tickets page since I needed to
  // Add dynamic number of children to the listview
  // I had to create a seperate function for the same.
  // I haven't found a more efficient way to do this (buy_ticket.dart)
  List<Widget> loadBuyTicketsListView(User user, Train train, DarkTheme theme,
      ScrollController listViewScroller, Seats seats) {
    List<Widget> children = [];
    String currClass = user.tickets.last.seatClass;

    children.add(
        BuyTicketsHeader(user: user, train: train, theme: theme, seats: seats));
    children.add(Padding(
      padding: setPadding(top: 8),
      child: TrainTimeBar(theme: theme, train: train, user: user),
    ));
    children.add(CitySelectCalender(
        theme: theme, user: user, transparentBackground: true));
    children.add(Padding(
      padding: setPadding(top: 8),
      child: SelectClass(
          train: train, theme: theme, user: user, buyTicketPage: true),
    ));

    children.add(Padding(
        padding: setPadding(top: 8),
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              currClass,
              style: urbanist(theme.labelWhite,
                  fontsize: fontSizeLarge, weight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: renderClassMetrics(
                  train.classes[allClasses.keys.toList().indexOf(currClass)]
                      .metrics,
                  theme),
            ),
          ],
        )));
    children.add(SelectCoachDropDownMenu(
        theme: theme,
        controller: listViewScroller,
        currClass: train.classes[allClasses.keys.toList().indexOf(currClass)],
        ticket: user.tickets.last));
    for (int i = 0;
        i <
            train.classes[allClasses.keys.toList().indexOf(currClass)].coaches
                .length;
        i++) {
      children.add(TicketGrid(
          user: user,
          theme: theme,
          currCoach: train
              .classes[allClasses.keys.toList().indexOf(currClass)].coaches[i],
          currClass: train.classes[allClasses.keys.toList().indexOf(currClass)],
          train: train,
          allSeats: seats));
    }

    return children;
  }

  // The grid is basically 4 rows with Column widgets. (ticket_grid.dart)
  Widget loadSeatGrid(
      DarkTheme theme, User user, Seats seats, Coach currCoach) {
    List<Widget> children = [];
    for (int i = 0; i < seats.seats.length; i++) {
      if (seats.seats[i].isNotEmpty) {
        children.add(i == 2
            ? Padding(
                padding: setPadding(left: 0, right: 24),
                child: Column(children: seats.seats[i]))
            : Column(children: seats.seats[i]));
      }
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  // Creates the overlay (buy_ticket.dart)
  OverlayEntry createOverlay(DarkTheme theme, User user, Train train) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) =>
          BlocBuilder<TicketSelectedCubit, TicketSelectedState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  color: theme.surfaceBlack.withOpacity(0.8),
                ),
                PaymentCard(theme: theme, user: user, train: train)
              ],
            ),
          );
        },
      ),
    );
    return overlayEntry;
  }

  // Checks whether current class has any tickets
  // That have been selected and render the tickets accordingly
  // (ticket_grid.dart)
  Widget checkWhetherSeatsPresent(
      DarkTheme theme, User user, Train train, int index) {
    List<Coach> coaches = train.classes
        .firstWhere((element) => element.name == user.tickets[index].seatClass)
        .coaches
        .where((element) {
      return element.seats[1].where((element) => element).toList().isNotEmpty;
    }).toList();
    if (coaches.isNotEmpty) {
      return TicketsListTile(
          theme: theme,
          ticket: user.tickets[index],
          user: user,
          train: train,
          coachesWithTickets: coaches);
    } else {
      return Container();
    }
  }

  // Used to make the card which shows all the tickets in Payment overlay (payment_tickets_list_item.dart)
  List<Widget> renderPaymentTicketsCard(Ticket ticket, DarkTheme theme,
      Train train, List<Coach> coachesWithTickets) {
    List<Widget> children = [
      Padding(
        padding: setPadding(top: 16, bottom: 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            ticket.seatClass,
            style: urbanist(theme.labelWhite,
                fontsize: fontSizeMedium, weight: FontWeight.w700),
          ),
          Text(
            ticket.coach.coachNumber,
            style: urbanist(theme.labelWhite,
                fontsize: fontSizeMedium, weight: FontWeight.w700),
          )
        ]),
      )
    ];
    children =
        addBerthSeats(children, theme, coachesWithTickets, train, ticket);
    return children;
  }

  // Adds Row widgets for berths according to the ones booked 
  // (Two lines above us)
  List<Widget> addBerthSeats(List<Widget> children, DarkTheme theme,
      List<Coach> coachesWithTickets, Train train, Ticket ticket) {
    Functions func = Functions();
    Map<String, List<String>> tickets = {
      "Lower": [],
      "Middle": [],
      "Upper": [],
      "Side": []
    };
    tickets = func.computeTicketsForPayment(
        tickets, coachesWithTickets, train, ticket);
    List<Widget> berthWidgets = [];
    for (var berth in tickets.entries) {
      if (berth.value.isNotEmpty) {
        List<Widget> berthSeats = [];
        List<String> seats = berth.value;
        int i = 0;
        while (i < seats.length) {
          String seatsInCurrentIndex;
          if (i + 3 <= seats.length) {
            seatsInCurrentIndex = seats.getRange(i, i + 3).toString();
          } else {
            seatsInCurrentIndex =
                seats.getRange(i, i + seats.length % 3).toString();
          }
          berthSeats.add(Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              seatsInCurrentIndex.substring(1, seatsInCurrentIndex.length - 1),
              style: urbanist(theme.labelWhite, weight: FontWeight.w800),
            ),
          ));
          i += 3;
        }
        berthWidgets.add(Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Padding(
                padding: setPadding(left: 0, right: 24),
                child: Text(
                  berth.key,
                  style: urbanist(theme.labelWhite, weight: FontWeight.w300),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: berthSeats)
            ],
          ),
        ));
      }
    }
    children.add(Padding(
      padding: setPadding(top: 16, bottom: 16),
      child: Column(children: berthWidgets),
    ));
    return children;
  }
}