import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/utils/theme.dart';
import 'package:weather_app/view/home.dart';

void main() async {
  await DotEnv().load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme:  AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}
