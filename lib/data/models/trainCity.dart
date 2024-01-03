// Stores the City information and time of arrival and dep at each station
import 'package:bharatrail/data/models/city.dart';

class TrainCity {
  City city;
  DateTime arrival;
  DateTime departure;

  TrainCity(
      {required this.city,
      required this.arrival,
      required this.departure});
}
