import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/location.dart';
import '../services/networking.dart';
import '../utilities/constants.dart';
import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future getLocationData() async {
    /// Get current location [longitude] and [latitude] using Geolocator API.
    Location location = Location();
    await location.getCurrentLocation();

    /// Make HTTP get request to get JSON data from Openweathermap.org for current [latitude] and [longitude].
    NetworkConnection networkConnection = NetworkConnection(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var jsonDecodedData = await networkConnection.getWeatherJsonData();
    print(jsonDecodedData);

    /// After obtaining the data, proceed to the home_page.dart.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          weatherData: jsonDecodedData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SpinKitPulse(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
