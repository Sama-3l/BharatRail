import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/train.dart';

class Ticket {
  int? seatNumber;
  String seatClass;
  Coach? coach;
  Train train;

  Ticket({this.seatNumber, required this.seatClass, this.coach, required this.train});
}
