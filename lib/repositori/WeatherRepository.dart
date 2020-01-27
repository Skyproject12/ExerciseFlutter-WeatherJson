import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/config/WeatherApiClient.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherRepository{ 
  final WeatherApiClient weatherApiClient; 
  WeatherRepository({ 
    @required this.weatherApiClient
  }) : assert(weatherApiClient != null);  
  // get the weather 
  Future<Weather> getWeather(String city) async {  
    // get the location
    final int locationId = await weatherApiClient.getLocationId(city); 
    // display the fetch  
    return weatherApiClient.fetchWeather(locationId);
  }
}