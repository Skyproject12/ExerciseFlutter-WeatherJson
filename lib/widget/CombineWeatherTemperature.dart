import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart' as model ;
import 'package:weather_flutter/widget/Temperature.dart';
import 'package:weather_flutter/widget/WeatherConditions.dart'; 
class CombineWeatherTemperature extends StatelessWidget { 
  final model.Weather weather; 
  CombineWeatherTemperature({Key key, @required this.weather}): assert(weather!=null), super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Row( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[ 
            Padding( 
              padding: EdgeInsets.all(20.0),  
              // menampilkan image sesuai condisi dari suatu weather 
              child: WeatherConditions(condition: weather.condition),
            ), 
            Padding( 
              padding: EdgeInsets.all(20.0), 
              // get teamperature  
              child: Temperature( 
                temperature: weather.temp, 
                high : weather.maxTemp, 
                low: weather.minTemmp  
              )
            )
          ],
        ), 
        Center( 
          child: Text( 
            // settext formatcpondition  
            weather.formattedCondition, 
            style: TextStyle( 
              fontSize:30, 
              fontWeight: FontWeight.w200, 
              color: Colors.black
            )
          ),
        )
      ],
    );
  }
}