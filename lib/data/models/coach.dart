// EACH COACH HAS n NO OF SEATS THAT IS DECIDED
// BY WHAT KIND OF COACH IT IS
// SO IT IS SET WHERE WE SET CLASS
// SINCE CLIENT SIDE DOESN'T CARE WHO BOUGHT THE SEATS
// THE SEATS FROM 1 to n IS AN ARRAY OF 2 BOOL VALUES
// 0 FOR NOT AVAIL AND 1 FOR AVAIL

class Coach {
  String coachNumber;
  List<List<bool>> seats = [
    [],
    []
  ]; // Contains 2 bool values first stores if it's already booked second stores if it's selected now

  Coach({required this.coachNumber});
}
