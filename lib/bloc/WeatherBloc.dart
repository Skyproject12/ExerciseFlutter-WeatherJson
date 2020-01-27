import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/WeatherState.dart';
import 'package:weather_flutter/bloc/bloc.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repositori/Repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{ 
  final WeatherRepository weatherRepository; 
  // initial repository  
  WeatherBloc({ @required this.weatherRepository}) : assert(weatherRepository!=null);
  @override
  // TODO: implement initialState
  // initial of the state 
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* { 
    // ketika event adalah method fetchweather 
    if(event is FetchWeather){  
      // jalanakan fungsi loading di state 
      yield WeatherLoading(); 
      try{  
        // lalu panggil repository 
        final Weather weather = await weatherRepository.getWeather(event.city); 
        // load data berdasarkan weather  
        yield WeatherLoaded(weather : weather);
      } catch(_){  
        // selain dari itu set error
        yield WeatherError(); 
      }
    }
  } 
  
}