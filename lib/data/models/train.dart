import 'package:bharatrail/data/repostitories/cities.dart';

class Train {
  String name;
  int number;
  Cities citiesCovered;
  List<int> daysOperational;

  Train(
      {required this.name,
      required this.number,
      required this.citiesCovered,
      required this.daysOperational});
}
