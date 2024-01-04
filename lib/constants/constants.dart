// Each class of ticket - Number of seats on one side in each class (functions.dart/initiateClasses())
Map<String, int> allClasses = {
  "SL": 4,
  "3E": 4,
  "3A": 4,
  "2A": 3,
  "1A": 2,
};

// Each class of ticket - The keyword given to the class, no of bogeys for each class (functions.dart/initiateCoaches())
Map<String, List<String>> keyForClass = {
  "SL": ["S", "12"],
  "3E": ["E", "6"],
  "3A": ["B", "6"],
  "2A": ["A", "4"],
  "1A": ["H", "3"]
};

// Each letter correspond to their index in the seats list in Seats object
Map<int, String> seatTypeIndex = {
  0 : "L",
  1 : "M",
  2 : "U",
  3 : "SL/SU" 
};

const int numberOfCompartmentsInBogey = 9;
int totalNumberOfRows = 2 * numberOfCompartmentsInBogey;  //2 rows in each bogey

const double fontSizeHeadingMedium = 40.0;
const double fontSizeHeading = 32.0;
const double fontSizeLarge = 24.0;
const double fontSizeMedium = 16.0;
const double fontSizeSmall = 8.0;
