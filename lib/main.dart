import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tangerang',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // show modal bottomsheet
                      showLocationBottomSheet(context);
                    },
                    child: const Placeholder(
                      fallbackWidth: 24,
                      fallbackHeight: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Text(
                '20 Agustus, Selasa',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Clouds',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Placeholder(
                    fallbackWidth: 50,
                    fallbackHeight: 50,
                    color: Colors.white,
                  ),
                ],
              ),
              const Text(
                'Few Clouds',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWeatherInfo('10°C', 'Temp', Icons.thermostat),
                  _buildWeatherInfo('75%', 'Humidity', Icons.water_drop),
                  _buildWeatherInfo('2 m/s', 'Wind', Icons.air),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Hari Ini',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildForecastItem('6 PM', '10°C'),
                  _buildForecastItem('9 PM', '24°C'),
                  _buildForecastItem('12 PM', '24°C'),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Besok',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildForecastItem('6 PM', '10°C'),
                  _buildForecastItem('9 PM', '24°C'),
                  _buildForecastItem('12 PM', '24°C'),
                  _buildForecastItem('12 PM', '24°C'),
                ],
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Lexend',
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastItem(String time, String temp) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Lexend',
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const Placeholder(
          fallbackWidth: 30,
          fallbackHeight: 30,
          color: Colors.white,
        ),
        Text(
          temp,
          style: const TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.grey[900],
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Tangerang',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    'Tangerang',
                    'Jakarta',
                    'Padang',
                    'Tangerang',
                    'Jakarta',
                    'Padang',
                    'Tangerang',
                    'Jakarta',
                    'Padang',
                  ]
                      .map((city) => ListTile(
                            title: Text(
                              city,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            onTap: () {
                              // Handle city selection
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
