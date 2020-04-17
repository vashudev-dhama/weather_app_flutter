import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class HomePage extends StatefulWidget {
  final weatherData;

  HomePage({this.weatherData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temperature;
  int condition;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '$temperature °C',
              textAlign: TextAlign.center,
              style: kTempTextStyle,
            ),
            Text(
              'description',
              textAlign: TextAlign.center,
              style: kMessageTextStyle,
            ),
            Text(
              'condition',
              textAlign: TextAlign.center,
              style: kConditionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
