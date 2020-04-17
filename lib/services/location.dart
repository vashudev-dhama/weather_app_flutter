import 'package:geolocator/geolocator.dart';

class Location {
  /// Longitude and Latitude of the current device location fetched.
  double longitude;
  double latitude;

  /// Async method to fetch the device's current location.
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
