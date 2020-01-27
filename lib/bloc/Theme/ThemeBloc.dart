import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Theme/ThemeEvent.dart';
import 'package:weather_flutter/bloc/Theme/ThemeState.dart';
import 'package:weather_flutter/model/WeatherCondition.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  // TODO: implement initialState
  ThemeState get initialState =>
      ThemeState(theme: ThemeData.light(), color: Colors.lightBlue);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is WeatherChanged) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

// check 
  ThemeState _mapWeatherConditionToThemeData(WeatherCondition condition) {
    ThemeState theme;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        theme = ThemeState(
            theme: ThemeData(
              primaryColor: Colors.orangeAccent,
            ),
            color: Colors.yellow);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.show:
      case WeatherCondition.sleet:
        theme = ThemeState(
            theme: ThemeData(
              primaryColor: Colors.lightBlueAccent,
            ),
            color: Colors.lightBlue);
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.blueGrey),
            color: Colors.grey);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.indigoAccent),
            color: Colors.indigo);
        break;
      case WeatherCondition.thunderstrom:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
            color: Colors.deepPurple);
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
        break;
    } 
    return theme;
  }
}
