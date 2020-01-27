import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

// membuat suatu fungsi berdasarkan api yang di request
class FetchWeather extends WeatherEvent {
  final String city;
  const FetchWeather({@required this.city}) : assert(city != null);
  @override
  List<Object> get props => [city];
}

// refresh the city 
class RefreshWeather extends WeatherEvent{
  final String city; 
  const  RefreshWeather({ 
    @required this.city
  }) : assert(city!=null); 
  // return list of city  
  @override
  List<Object> get props => [city]; 

}