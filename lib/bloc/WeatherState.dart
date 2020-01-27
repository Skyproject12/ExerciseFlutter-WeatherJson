import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/model/Weather.dart';

abstract class WeatherState extends Equatable{ 
  const WeatherState(); 
  @override 
  List<Object> get props => [];
} 
class WeatherEmpty extends WeatherState{ 
  
} 
class WeatherLoading extends WeatherState{ 

} 
class WeatherLoaded extends WeatherState{ 
  final Weather weather; 
  const WeatherLoaded({@required this.weather}) : assert(weather!= null); 
  @override  
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState{ 
  
}
