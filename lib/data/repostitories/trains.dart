import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/repostitories/cities.dart';

class Trains {
  List<Train> trains = [
    Train(
        name: "Tamil Nadu Exp",
        number: 12622,
        citiesCovered: Cities().initiateCities(),
        daysOperational: [
          DateTime.monday,
          DateTime.wednesday,
          DateTime.saturday
        ]),
    Train(
        name: "Grand Trunk Exp",
        number: 22651,
        citiesCovered: Cities().initiateCities(),
        daysOperational: [DateTime.monday, DateTime.tuesday, DateTime.thursday])
  ];
}
