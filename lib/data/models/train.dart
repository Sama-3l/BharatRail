import 'package:bharatrail/data/models/class.dart';
import 'package:bharatrail/data/models/trainCity.dart';

class Train {
  String name;
  int number;
  List<TrainCity> citiesCovered;
  List<int> daysOperational;
  List<Class> classes;

  Train(
      {required this.name,
      required this.number,
      required this.citiesCovered,
      required this.daysOperational,
      required this.classes});
}
