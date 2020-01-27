import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Weather/WeatherEvent.dart';
import 'package:weather_flutter/bloc/Weather/WeatherState.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repositori/Repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  // initial repository
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);
  @override
  // TODO: implement initialState
  // initial of the state
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // ketika event adalah method fetchweather
    if (event is FetchWeather) { 
      yield* _mapFetchWeathertoState(event);
    } 
    else if(event is RefreshWeather){ 
      yield* _mapRefreshWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapFetchWeathertoState(FetchWeather event) async* {
    yield WeatherLoading();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield WeatherError();
    }
  }

  Stream<WeatherState> _mapRefreshWeatherToState(RefreshWeather event) async* {
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield state;
    }
  }
}
