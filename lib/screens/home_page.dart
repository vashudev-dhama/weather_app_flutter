import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:climateflutter/services/weather.dart';

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
    print('home page init occur --------------------');
    updateUI(widget.weatherData);
    print('updateUI homepage occur ------------------');
//    print(widget.weatherData);
  }

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
      humidity = weatherData['main']['humidity']; // in % TODO
      cloudiness = weatherData['clouds']['all']; //in % TODO
      weatherDescription = weatherData['weather'][0]['main'];
      windSpeed = weatherData['wind']['speed']; // in m/s TODO
      cityName = weatherData['name'];
    });
  }

  Future getInputCityData(String inputCity) async {
    /// Get the weather data using [inputCity] and openweather.org API.
    print('getCityData homepage occur----------------');
    var jsonDecodeData = await WeatherModel().getCityWeather(inputCity);
    print('city-wise jsonDecodedData fetched------------------');
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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                          print(
                              'current city data requested-------------------');
                        },
                        child: Icon(
                          Icons.my_location,
                          size: 40.0,
                          color: Colors.white70,
                        ),
                      ),
                    ),
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Hide the keypad.
                          FocusScope.of(context).unfocus();
                          print(inputCity);
                          var localWeatherData =
                              await getInputCityData(inputCity);
                          _controller.clear();
                          setState(() {
                            updateUI(localWeatherData);
                          });
                          print(
                              'city-wise data requested-----------------------');
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
              Text(
                cityName,
                style: kCityTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 80.0,
                height: 10.0,
                child: Divider(
                  thickness: 2.0,
                  color: Colors.white70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  weatherDescription,
                  textAlign: TextAlign.center,
                  style: kDescriptionTextStyle,
                ),
              ),
              Text(
                '$temperature°C',
                style: kTempTextStyle,
              ),
              Text(
                '${humidity.toString()}%',
                style: kHumidityTextStyle,
              ),
              Text(
                '${windSpeed.toStringAsFixed(1)}mps',
                style: kWindSpeedTextStyle,
              ),
              Text(
                '${cloudiness.toString()}%',
                style: kCloudinessTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
