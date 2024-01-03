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
