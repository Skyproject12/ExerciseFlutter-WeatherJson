import 'package:flutter_bloc/flutter_bloc.dart';

// menampung transisis pada suatu bloc sehingga 
// ketika bloc sudah banyak dapat dilihat 
class SimpleBlocDelegate extends BlocDelegate { 
  @override 
  void onEvents(Bloc bloc, Object event){ 
    super.onEvent(bloc, event); 
    print('onEvent $event');
  }

  @override 
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition); 
    print('onTransition $transition');
  }
  
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(bloc, error, stacktrace); 
    print('onError $error');
  }

}