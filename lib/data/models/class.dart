import 'package:bharatrail/data/models/coach.dart';

class Class {
  String name;
  int dimensionOfClass; // No of seats on one side; S, 3A - 4; 2A - 3; 1A - 2
  List<int> metrics;
  List<Coach> coaches;

  Class(
      {required this.name,
      required this.dimensionOfClass,
      required this.metrics,
      required this.coaches});
}
