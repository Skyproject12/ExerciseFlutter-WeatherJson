import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:weather_flutter/model/Weather.dart';

// get request api 
class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;
  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);  
  // initial of api 
  Future<int> getLocationId(String city) async { 
    final locationUrl = '$baseUrl/api/location/search/?query=$city'; 
    final locationResponse = await this.httpClient.get(locationUrl); 
    if(locationResponse.statusCode != 200){ 
      throw Exception('error getting locationId for city');
    } 
    // convert the json into the arraylist   
    final locationJson = jsonDecode(locationResponse.body) as List; 
    return (locationJson.first)['woeid'];  
  } 
  // initial api 
  Future<Weather> fetchWeather(int locationId) async { 
    final weatherUrl = '$baseUrl/api/location/$locationId'; 
    final weatherResponse = await this.httpClient.get(weatherUrl); 
    if(weatherResponse.statusCode != 200){ 
      throw Exception('error getting weather for location');
    }  
    // call the result of json 
    final weatherJson = jsonDecode(weatherResponse.body); 
    return Weather.fromJson(weatherJson);
  }
}
