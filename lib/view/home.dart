import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tangerang',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '20 Agustus, Selasa',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: InkWell(
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
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clouds',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Few Clouds',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Placeholder(
                      fallbackWidth: 50,
                      fallbackHeight: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 72),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherInfo(context, '10°C', 'Temp', Icons.thermostat),
                      Container(
                        width: 2,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary,
                        ),
                      ),
                      _buildWeatherInfo(context, '75%', 'Humidity', Icons.water_drop),
                      Container(
                        width: 2,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary,
                        ),
                      ),
                      _buildWeatherInfo(context, '2 m/s', 'Wind', Icons.air),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hari Ini',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '20 Agustus, 2024',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    late EdgeInsets padding = const EdgeInsets.only(right: 10);

                    if (i == 10 - 1) {
                      padding = EdgeInsets.zero;
                    }

                    return Padding(
                      padding: padding,
                      child: _buildForecastItem(context, '6', 'PM', '10°C'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Besok',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '20 Agustus, 2024',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    late EdgeInsets padding = const EdgeInsets.only(right: 10);

                    if (i == 10 - 1) {
                      padding = EdgeInsets.zero;
                    }

                    return Padding(
                      padding: padding,
                      child: _buildForecastItem(context, '6', 'PM', '10°C'),
                    );
                  },
                ),
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 34),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w400, color: AppColors.textPrimary),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildForecastItem(BuildContext context, String time, String meridiem, String temp) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(text: time, style: Theme.of(context).textTheme.bodyMedium, children: [
              TextSpan(text: ' $meridiem', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11))
            ]),
          ),
          const SizedBox(height: 5),
          const Placeholder(
            fallbackWidth: 30,
            fallbackHeight: 30,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            temp,
            style: const TextStyle(
              fontFamily: 'Lexend',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
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
