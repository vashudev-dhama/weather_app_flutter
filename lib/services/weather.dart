import '../services/location.dart';
import '../services/networking.dart';
import '../utilities/constants.dart';

class WeatherModel {
  /// Get data by [cityName].
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkConnection networkConnection = NetworkConnection(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var jsonDecodedData = await networkConnection.getWeatherJsonData();
    return jsonDecodedData;
  }

  /// Get data by [longitude] and [latitude].
  Future<dynamic> getLocationWeather() async {
    //Get current location [longitude] and [latitude] using Geolocator API.
    Location location = Location();
    await location.getCurrentLocation();

    // Make HTTP get request to get JSON data from Openweathermap.org for current [latitude] and [longitude].
    NetworkConnection networkConnection = NetworkConnection(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var jsonDecodedData = await networkConnection.getWeatherJsonData();
    return jsonDecodedData;
  }
}
