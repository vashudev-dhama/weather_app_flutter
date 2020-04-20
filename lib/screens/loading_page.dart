import 'package:climateflutter/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climateflutter/services/weather.dart';

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
    /// Get the weather data using Geolocator and Openweathermap.org APIs.
    var jsonDecodedData = await WeatherModel().getLocationWeather();
    print('jsonDecodeData on loading page:====>>>> $jsonDecodedData');

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loading_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SpinKitPulse(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
