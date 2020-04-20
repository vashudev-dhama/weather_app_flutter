import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:climateflutter/services/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:climateflutter/utilities/reusable_tiles.dart';

class HomePage extends StatefulWidget {
  final weatherData;

  HomePage({this.weatherData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  var _controller = TextEditingController(); // to clear text in textfield.
  double temperature;
  int humidity;
  int cloudiness;
  double windSpeed;
  String weatherDescription;
  String cityName;
  String inputCity;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  /// To update the UI based on fetched [weatherData].
  void updateUI(dynamic weatherData) {
    setState(() {
      /// If for any reason, weatherData couldn't be fetched.
      if (weatherData == null) {
        temperature = 0;
        weatherDescription = "CITY NOT FOUND!!";
        cityName = '404 :( ';
        humidity = 0;
        cloudiness = 0;
        windSpeed = 0.0;
        return;
      }
      double temp = num.parse(weatherData['main']['temp'].toStringAsFixed(1));
      temperature = temp;
      humidity = weatherData['main']['humidity'];
      cloudiness = weatherData['clouds']['all'];
      weatherDescription = weatherData['weather'][0]['main'];
      windSpeed = weatherData['wind']['speed'];
      cityName = weatherData['name'];
    });
  }

  Future getInputCityData(String inputCity) async {
    /// Get the weather data using [inputCity] and openweather.org API.
    var jsonDecodeData = await WeatherModel().getCityWeather(inputCity);
    return jsonDecodeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /// My location icon goes here.
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.my_location,
                          size: 40.0,
                          color: Colors.white70,
                        ),
                      ),
                    ),

                    /// TextField goes here.
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Enter city here',
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        onChanged: (value) {
                          inputCity = value;
                        },
                      ),
                    ),

                    /// Search icon goes here.
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus(); // Hide the keypad.
                          var localWeatherData =
                              await getInputCityData(inputCity);
                          _controller.clear();
                          setState(() {
                            updateUI(localWeatherData);
                          });
                        },
                        child: Icon(
                          Icons.search,
                          size: 40.0,
                          color: Colors.white70,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// City name goes here.
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  cityName,
                  style: kCityTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),

              /// Divider line here.
              SizedBox(
                width: 100.0,
                height: 10.0,
                child: Divider(
                  thickness: 2.0,
                  color: Colors.white70,
                ),
              ),

              /// Weather Description shown here.
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  weatherDescription,
                  textAlign: TextAlign.center,
                  style: kDescriptionTextStyle,
                ),
              ),

              /// Fetched Temperature shown here.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$temperature°C',
                  style: kTempTextStyle,
                ),
              ),

              /// Tiles for Humidity, Clouds and Wind goes here.
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Row(
                  children: <Widget>[
                    ReusableTiles(
                      weatherPropertyName: 'Humidity',
                      weatherPropertyValue: humidity,
                      weatherPropertyUnit: '%',
                      color: kHumidityTileColor,
                      weatherPropertyIcon: FontAwesomeIcons.tint,
                    ),
                    ReusableTiles(
                      weatherPropertyName: 'Clouds',
                      weatherPropertyValue: cloudiness,
                      weatherPropertyUnit: '%',
                      color: kCloudsTileColor,
                      weatherPropertyIcon: Icons.cloud,
                    ),
                    ReusableTiles(
                      weatherPropertyName: 'Wind',
                      weatherPropertyValue: windSpeed * 2.237, //convert to mph
                      weatherPropertyUnit: 'mph',
                      color: kWindTileColor,
                      weatherPropertyIcon: FontAwesomeIcons.wind,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
