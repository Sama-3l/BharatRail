import 'package:bharatrail/data/models/city.dart';

class User {
  String name;
  City arrCity;
  City depCity;
  DateTime depTime;

  User(
      {required this.name,
      required this.arrCity,
      required this.depCity,
      required this.depTime});
}
