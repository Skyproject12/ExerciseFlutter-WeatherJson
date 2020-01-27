import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/WeatherBloc.dart';
import 'package:weather_flutter/config/WeatherApiClient.dart';
import 'package:weather_flutter/repositori/Repository.dart';
import 'package:weather_flutter/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/widget/Weather.dart';

void main() {
  // call simple bloc delegate
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // defination weather repository
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
    httpClient: http.Client(),
  ));
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  // defination send the repository from main class
  final WeatherRepository weatherRepository;
  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',  
      // defination bloc provider
      home: BlocProvider( 
        create: (context) => WeatherBloc(weatherRepository: weatherRepository), 
        // set weather  
        child: Weather(),
      ),
    );
  }
}
