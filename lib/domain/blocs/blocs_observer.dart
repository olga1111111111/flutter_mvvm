import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class BlocsObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {

    super.onCreate(bloc);
    print(bloc);
  }
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(bloc);
    print(event);
    super.onEvent(bloc, event);
  }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {

    super.onError(bloc, error, stackTrace);
    print(bloc);
  }
}