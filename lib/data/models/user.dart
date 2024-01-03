import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/ticket.dart';

class User {
  String name;
  City arrCity;
  City depCity;
  DateTime depTime;
  List<Ticket> tickets = [];

  User(
      {required this.name,
      required this.arrCity,
      required this.depCity,
      required this.depTime});
}
