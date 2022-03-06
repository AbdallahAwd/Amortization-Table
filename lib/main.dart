import 'package:flutter/material.dart';
import 'package:project/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.grey, elevation: 0.0),
          scaffoldBackgroundColor: Colors.grey),
      home: Home(),
    );
  }
}
