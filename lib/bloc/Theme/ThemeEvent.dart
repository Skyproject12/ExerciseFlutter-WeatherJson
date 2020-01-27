import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/model/WeatherCondition.dart';  
// theme event 
abstract class ThemeEvent extends Equatable{ 
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent{ 
  final WeatherCondition condition; 
  const WeatherChanged({@required this.condition}) : assert(condition!=null); 
  @override
  // TODO: implement props
  List<Object> get props => [condition]; 

}