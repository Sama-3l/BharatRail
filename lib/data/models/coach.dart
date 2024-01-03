// EACH COACH HAS n NO OF SEATS THAT IS DECIDED

// BY WHAT KIND OF COACH IT IS

// SO IT IS SET WHERE WE SET CLASS

// SINCE CLIENT SIDE DOESN'T CARE WHO BOUGHT THE SEATS

// THE SEATS FROM 1 to n IS AN ARRAY OF BOOL

// 0 FOR ALREADY BOUGHT AND 1 FOR AVAIL

class Coach {
  String coachNumber;
  List<bool> seats;

  Coach({required this.coachNumber, required this.seats});
}
