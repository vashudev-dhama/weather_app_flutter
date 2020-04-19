import '../services/location.dart';
import '../services/networking.dart';
import '../utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkConnection networkConnection = NetworkConnection(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var jsonDecodedData = await networkConnection.getWeatherJsonData();
    return jsonDecodedData;
  }

  Future<dynamic> getLocationWeather() async {
    /// Get current location [longitude] and [latitude] using Geolocator API.
    Location location = Location();
    await location.getCurrentLocation();

    /// Make HTTP get request to get JSON data from Openweathermap.org for current [latitude] and [longitude].
    NetworkConnection networkConnection = NetworkConnection(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var jsonDecodedData = await networkConnection.getWeatherJsonData();
    return jsonDecodedData;
  }

//  String getWeatherIcon(int condition) {
//    if (condition < 300) {
//      return '🌩';
//    } else if (condition < 400) {
//      return '🌧';
//    } else if (condition < 600) {
//      return '☔️';
//    } else if (condition < 700) {
//      return '☃️';
//    } else if (condition < 800) {
//      return '🌫';
//    } else if (condition == 800) {
//      return '☀️';
//    } else if (condition <= 804) {
//      return '☁️';
//    } else {
//      return '🤷‍';
//    }
//  }

//  String getMessage(double temp) {
//    if (temp > 25) {
//      return 'It\'s 🍦 time';
//    } else if (temp > 20) {
//      return 'Time for shorts and 👕';
//    } else if (temp < 10) {
//      return 'You\'ll need 🧣 and 🧤';
//    } else {
//      return 'Bring a 🧥 just in case';
//    }
//  }
}
