import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Theme/ThemeBloc.dart';
import 'package:weather_flutter/bloc/Theme/ThemeEvent.dart';
import 'package:weather_flutter/bloc/Theme/ThemeState.dart';
import 'package:weather_flutter/bloc/Weather/WeatherBloc.dart';
import 'package:weather_flutter/bloc/Weather/WeatherEvent.dart';
import 'package:weather_flutter/widget/CitySelection.dart';
import 'package:weather_flutter/widget/CombineWeatherTemperature.dart';
import 'package:weather_flutter/bloc/Weather/WeatherState.dart';
import 'package:weather_flutter/widget/GradientContainer.dart';
import 'package:weather_flutter/widget/Setting.dart';
import 'LastUpdated.dart';
import 'Location.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ));
            },
          ),
          IconButton(
              icon: Icon(Icons.search),
              // click search
              onPressed: () async {
                final city = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      // call the value of edittext or city
                      builder: (context) => CitySelection(),
                    ));
                if (city != null) {
                  // call the fungsi fetch all
                  BlocProvider.of<WeatherBloc>(context)
                      .add(FetchWeather(city: city));
                }
              })
        ],
      ),
      body: Center(child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoaded) {
            BlocProvider.of<ThemeBloc>(context)
                .add(WeatherChanged(condition: state.weather.condition));
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
          child:
          BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherEmpty) {
              return Center(
                child: Text('Please Select a Location'),
              );
            }
            if (state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoaded) {
              // call the response of weather 
              final weather = state.weather; 
              // make response of the bloc for themeState
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return GradientContainer( 
                  // custom color 
                    color: themeState.color,
                    child: RefreshIndicator(
                        onRefresh: () {
                          BlocProvider.of<WeatherBloc>(context).add(
                              RefreshWeather(city: state.weather.location));
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          // list of the location lastupdate and combineWeatherTemperature
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                // tampilkan location
                                child: Location(location: weather.location),
                              ),
                            ),
                            Center(
                              // tampilkan last update
                              child: LastUpdated(dateTime: weather.lastUpdated),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                // tampilkan temperature
                                child:
                                    CombineWeatherTemperature(weather: weather),
                              ),
                            )
                          ],
                        )));
              });
            }
            if (state is WeatherError) {
              return Text(
                'Something went wring!',
                style: TextStyle(color: Colors.red),
              );
            }
          });
        },
      )),
    );
  }
}
