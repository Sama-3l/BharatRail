import 'package:bharatrail/data/models/city.dart';

class Cities {
  List<City> cities = [];

  // Initiate cities for now since I couldn't find api to get all cities
  Cities initiateCities() {
    List<String> cities = [
      'New Delhi',
      'Mumbai',
      'Chennai',
      'Lucknow',
      'Ahemdabad',
      'Kolkata',
      'Panjim',
      'Surat',
      'Kanpur',
      'Jhansi',
      'Allahabad',
      'Patna',
      'Srinagar',
      'Kanyakumari',
      'Manali',
      'Chandigarh',
      'Haridwar'
    ];
    Cities allCities = Cities();
    for (var city in cities) {
      allCities.cities.add(City(name: city));
    }
    return allCities;
  }
}
