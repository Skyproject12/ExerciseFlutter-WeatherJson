import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/Setting/SettingEvent.dart';
import 'package:weather_flutter/bloc/Setting/SettingState.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState>{
  @override
  // TODO: implement initialState
  SettingState get initialState => SettingState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if(event is TemperatureUnitsToggled){
      yield SettingState( 
        temperatureUnits: state.temperatureUnits == TemperatureUnits.celsius ? 
        TemperatureUnits.fahrenheit 
        : TemperatureUnits.celsius
      );
    }
  } 
  
}