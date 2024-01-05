import 'package:bharatrail/data/models/coach.dart';
import 'package:bharatrail/data/models/train.dart';

class Ticket {
  String seatClass;
  Coach coach;
  Train train;

  Ticket({required this.seatClass, required this.coach, required this.train});
}
