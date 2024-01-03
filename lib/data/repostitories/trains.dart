import 'package:bharatrail/data/models/city.dart';
import 'package:bharatrail/data/models/train.dart';
import 'package:bharatrail/data/models/trainCity.dart';
import 'package:bharatrail/functions/functions.dart';

// This is sample data for trains to generate and test the app.
class Trains {
  List<Train> trains = [
    Train(
        name: "Tamil Nadu Exp",
        number: 12622,
        citiesCovered: [
          // Cities are in the order 0 to n-1
          // Where their index corresponds to their position 
          // Relative to dep and arrival stations
          // Of the train
          TrainCity(
              city: City(name: "New Delhi"),
              arrival: DateTime(2024, 1, 2, 21, 5),
              departure: DateTime(2024, 1, 2, 21, 5)),
          TrainCity(
              city: City(name: "Jhansi"),
              arrival: DateTime(2024, 1, 2, 23, 50),
              departure: DateTime(2024, 1, 2, 23, 50)),
          TrainCity(
              city: City(name: "Chennai"),
              arrival: DateTime(2024, 1, 4, 6, 35),
              departure: DateTime(2024, 1, 4, 6, 35))
        ],
        daysOperational: [
          DateTime.monday,
          DateTime.wednesday,
          DateTime.saturday
        ],
        classes: Functions().initiateClasses()),
    Train(
        name: "Grand Trunk Exp",
        number: 22651,
        citiesCovered: [
          TrainCity(
              city: City(name: "New Delhi"),
              arrival: DateTime(2024, 1, 2, 12, 20),
              departure: DateTime(2024, 1, 2, 12, 20)),
          TrainCity(
              city: City(name: "Jhansi"),
              arrival: DateTime(2024, 1, 2, 15, 15),
              departure: DateTime(2024, 1, 2, 15, 15)),
          TrainCity(
              city: City(name: "Chennai"),
              arrival: DateTime(2024, 1, 3, 23, 55),
              departure: DateTime(2024, 1, 3, 23, 55))
        ],
        daysOperational: [DateTime.monday, DateTime.tuesday, DateTime.thursday],
        classes: Functions().initiateClasses())
  ];
}
