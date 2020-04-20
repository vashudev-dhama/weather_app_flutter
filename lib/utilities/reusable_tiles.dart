import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableTiles extends StatefulWidget {
  final weatherPropertyValue;
  final weatherPropertyName;
  final weatherPropertyUnit;
  final Color color;
  final weatherPropertyIcon;
  ReusableTiles({
    this.weatherPropertyName,
    this.weatherPropertyValue,
    this.weatherPropertyUnit,
    this.color,
    this.weatherPropertyIcon,
  });
  _ReusableTilesState createState() => _ReusableTilesState();
}

class _ReusableTilesState extends State<ReusableTiles> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(
              Radius.circular(60.0),
            ),
          ),
          width: 50.0,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Progress bar goes here.
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: (widget.weatherPropertyName == 'Wind')
                    ? (widget.weatherPropertyValue) / 25
                    : (widget.weatherPropertyValue) / 100,
                center: Icon(widget.weatherPropertyIcon),
                progressColor: Color(0xFFfcff70),
                backgroundColor: Colors.white54,
              ),
              SizedBox(
                height: 5.0,
              ),

              /// Property value goes here.
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (widget.weatherPropertyName == 'Wind')
                        ? '${widget.weatherPropertyValue.toStringAsFixed(1)}'
                        : '${widget.weatherPropertyValue}',
                    textAlign: TextAlign.center,
                    style: kReusableTileTextValueStyle,
                  ),
                  Text(
                    '${widget.weatherPropertyUnit}',
                    style: kWeatherPropertyUnitTextStyle,
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),

              /// Property name goes here.
              Text(
                '${widget.weatherPropertyName}',
                textAlign: TextAlign.center,
                style: kReusableTileTextLabelStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
