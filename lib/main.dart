import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Theme/ThemeBloc.dart';
import 'package:weather_flutter/bloc/Theme/ThemeState.dart';
import 'package:weather_flutter/config/WeatherApiClient.dart';
import 'package:weather_flutter/repositori/Repository.dart';
import 'package:weather_flutter/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/widget/Weather.dart';
import 'bloc/Weather/WeatherBloc.dart';

void main() {
  // call simple bloc delegate
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // defination weather repository
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
    httpClient: http.Client(),
  ));
  runApp( 
    MultiBlocProvider( 
      providers: [ 
        BlocProvider<ThemeBloc>( 
          create: (context) => ThemeBloc(),
        ), 
      ], 
      child: App(weatherRepository: weatherRepository)
    )
  );
}

class App extends StatelessWidget {
  // defination send the repository from main class
  final WeatherRepository weatherRepository;
  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather',
          // defination bloc provider
          home: BlocProvider( 
            // initial global bloc
            create: (context) => 
            // this can use any page because bloc global 
                WeatherBloc(weatherRepository: weatherRepository),
            // set weather
            child: Weather(),
          ),
        );
      },
    );
  }
}
