import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum TemperatureUnits { 
  fahrenheit, celsius
} 
// state of setting 
class SettingState extends Equatable{ 
  final TemperatureUnits temperatureUnits; 
  const SettingState ({@required this.temperatureUnits}): assert(temperatureUnits!=null); 
  @override
  // save the temperature yang terdiri dari enum 
  List<Object> get props => [temperatureUnits]; 

}