import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/WeatherBloc.dart';
import 'package:weather_flutter/bloc/WeatherState.dart';
import 'package:weather_flutter/bloc/bloc.dart';
import 'package:weather_flutter/widget/CitySelection.dart';
import 'package:weather_flutter/widget/CombineWeatherTemperature.dart';

import 'LastUpdated.dart';
import 'Location.dart';
class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Flutter Weather'), 
        actions: <Widget>[ 
          IconButton( 
            icon: Icon(Icons.search), 
            // click search  
            onPressed: ( ) async { 
              final city = await Navigator.push(context, MaterialPageRoute( 
                // call the value of edittext or city  
                builder: (context) => CitySelection(),
              )); 
              if(city!=null){  
                // call the fungsi fetch all 
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city:city));
              }
            }
          )
        ],
      ), 
      body: Center( 
        child: BlocBuilder<WeatherBloc, WeatherState>( 
          builder: (context, state){ 
            if(state is WeatherEmpty){ 
              return Center(child: Text('Please Select a Location'),);
            } 
            if(state is WeatherLoading){ 
              return Center(child: CircularProgressIndicator(),);
            } 
            if(state is WeatherLoaded){  
              // call the response
              final weather = state.weather; 
              return ListView(  
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
                      child: CombineWeatherTemperature( 
                        weather:weather
                      ),
                    ),
                  )
                ],
              );
            } 
            if(state is WeatherError){ 
              return Text('Something went wring!', style: TextStyle(color: Colors.red),);
            }
          },
        )
      ),
    );
  }
}