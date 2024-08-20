import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/core/service_locator.dart';
import 'package:weather_app/utils/theme.dart';
import 'package:weather_app/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // await DotEnv().load(fileName: ".env");
  initializeServices();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => sl<WeatherBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
