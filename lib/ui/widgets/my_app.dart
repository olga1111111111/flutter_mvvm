import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/ui/widgets/auth_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWidget.create(),
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(),
      ),
    );
  }
}
