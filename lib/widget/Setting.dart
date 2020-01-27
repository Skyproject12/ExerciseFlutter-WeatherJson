import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Setting/SettingBloc.dart';
import 'package:weather_flutter/bloc/Setting/SettingEvent.dart';
import 'package:weather_flutter/bloc/Setting/SettingState.dart';
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    final settingBloc = BlocProvider.of<SettingBloc>(context);
    return Scaffold( 
      appBar: AppBar(title: Text('Setting')), 
      body: ListView( 
        children: <Widget>[ 
          BlocBuilder<SettingBloc, SettingState>( 
            builder: (context, state){ 
              return ListTile( 
                title: Text( 
                  'Temperature Unit'
                ), 
                isThreeLine: true, 
                subtitle: Text('Use metric mesurement for temperature unit'), 
                trailing: Switch( 
                  value: state.temperatureUnits == TemperatureUnits.celsius, 
                  onChanged: (_)=> BlocProvider.of<SettingBloc>(context)
                  .add(TemperatureUnitsToggled()),
                ),
              );
            }
          )
        ],
      )
    );
  }
}