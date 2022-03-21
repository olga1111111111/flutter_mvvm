import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'example_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (_) => ViewModel(), child: const ExampleWidget()),
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(),
      ),
    );
  }
}
