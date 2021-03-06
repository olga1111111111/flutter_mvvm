import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/ui/widgets/auth_widget.dart';
import 'package:flutter_application_mvvm/ui/widgets/example_widget.dart';

import 'package:flutter_application_mvvm/ui/widgets/loader_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoaderWidget.create(),
      title: "Flutter Demo",
      // routes: {
      //   'loader': (_) => LoaderWidget.create(),
      // },
      //   'auth': (_) => AuthWidget.create(),
      //   'example': (_) => ExampleWidget.create()
      // },
      //показ экрана без анимации после экрана загрузки:
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == 'auth') {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                AuthWidget.create(),
            transitionDuration: Duration.zero,
          );
        } else if (settings.name == 'example') {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ExampleWidget.create(),
            transitionDuration: Duration.zero,
          );
        } else //if (settings.name == 'loader')
        {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                LoaderWidget.create(),
            transitionDuration: Duration.zero,
          );
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(),
      ),
    );
  }
}
