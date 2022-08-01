import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/domain/blocs/blocs_observer.dart';
import 'package:flutter_application_mvvm/ui/widgets/my_app.dart';

void main() {
  const app = MyApp();
  BlocOverrides.runZoned(
        () {

          runApp(app);
      },
    blocObserver:  BlocsObserver(),
  );

}
