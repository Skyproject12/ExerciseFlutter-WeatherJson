import 'package:flutter/material.dart';
import 'package:weather_flutter/bloc/Setting/SettingState.dart';

class Temperature extends StatelessWidget {
  final double temperature;
  final double low;
  final double high;
  final TemperatureUnits unit;

// get temp the data from CombineWeatherTemperature
  Temperature({Key key, this.temperature, this.low, this.high, this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          // melalukan formatb dari temperature
          child: Text(
            '${_formattedTemperature(temperature)}°',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w100, color: Colors.black),
          ),
        ),
        Column(
          children: [
            Text(
              'max: ${_formattedTemperature(high)} °',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Colors.black),
            ),
            Text(
              'min: ${_formattedTemperature(low)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Colors.black),
            ),
          ],
        )
      ],
    );
  }

  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
  // membualatkan suatu bilangan
  int _formattedTemperature(double t) =>
      unit == TemperatureUnits.fahrenheit ? _toFahrenheit(t) : t.round();
}
