import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/train.dart';

class Ticket {
  int? seatNumber;
  String seatClass;
  Coach coach;
  Train train;
  String? seatTypeIndex;

  Ticket({this.seatNumber, this.seatTypeIndex, required this.seatClass, required this.coach, required this.train});
}
