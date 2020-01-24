import 'package:equatable/equatable.dart';
import 'package:weather_flutter/widget/WeatherCondition.dart';

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemmp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather(
      {this.condition,
      this.formattedCondition,
      this.minTemmp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location});

  @override
  // TODO: implement props
  List<Object> get props => [
        condition,
        formattedCondition,
        minTemmp,
        temp,
        maxTemp,
        created,
        lastUpdated,
        location
      ];

// format of json to object
  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
        condition: _mapStrignWeatherCondition(
            consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'],
        minTemmp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: json['woeid'] as int,
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: json['title']);
  }

  static WeatherCondition _mapStrignWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.show;
        break;
      case 's1':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstrom;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
