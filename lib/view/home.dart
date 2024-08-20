import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/core/date_formatter.dart';
import 'package:weather_app/core/extensions.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _cityPicked;

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeather(city: _cityPicked));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading || state is WeatherInitial) {
            return const LoadingIndicator();
          } else if (state is WeatherError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<WeatherBloc>()
                          .add(GetWeather(city: _cityPicked));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                    child: Text(
                      'Retry',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            );
          } else if (state is WeatherLoaded) {
            return RefreshIndicator(
              color: AppColors.textPrimary,
              backgroundColor: AppColors.secondary,
              onRefresh: () async {
                context.read<WeatherBloc>().add(GetWeather(city: _cityPicked));
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    primary: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 160),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.currentDayForecast.weather[0].main!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    state.currentDayForecast.weather[0]
                                        .description!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Image.asset(
                                state.currentDayForecast.weather[0].main!
                                    .toIconPath,
                                width: MediaQuery.of(context).size.width * 0.35,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 72),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildWeatherInfo(
                                    context,
                                    '${state.currentDayForecast.main!.temp}°C',
                                    'Temp',
                                    Icons.thermostat),
                                Container(
                                  width: 2,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primary,
                                  ),
                                ),
                                _buildWeatherInfo(
                                    context,
                                    '${state.currentDayForecast.main!.humidity}%',
                                    'Humidity',
                                    Icons.water_drop),
                                Container(
                                  width: 2,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primary,
                                  ),
                                ),
                                _buildWeatherInfo(
                                    context,
                                    '${state.currentDayForecast.wind!.speed} m/s',
                                    'Wind',
                                    Icons.air),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),
                        ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount:
                                state.multipleDaysForecast.groupedByDate.length,
                            itemBuilder: (context, i) {
                              final day = state
                                  .multipleDaysForecast.groupedByDate.keys
                                  .elementAt(i);
                              final date = state.multipleDaysForecast
                                  .groupedByDate[day]?[0].dtTxt!;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 21),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _formatDay(day),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          Text(
                                            DateFormatter.format(
                                                date ?? DateTime.now()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppColors
                                                        .textSecondary),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        itemCount: state.multipleDaysForecast
                                            .groupedByDate[day]!.length,
                                        itemBuilder: (context, i) {
                                          final item = state
                                              .multipleDaysForecast
                                              .groupedByDate[day]![i];
                                          EdgeInsets padding =
                                              const EdgeInsets.only(right: 10);

                                          if (i ==
                                              state
                                                      .multipleDaysForecast
                                                      .groupedByDate[day]!
                                                      .length -
                                                  1) {
                                            padding = EdgeInsets.zero;
                                          }

                                          return Padding(
                                            padding: padding,
                                            child: _buildForecastItem(
                                                context,
                                                DateFormatter.getHourAmFormat(
                                                    item.dtTxt ??
                                                        DateTime.now()),
                                                DateFormatter.getAmPm(
                                                    item.dtTxt ??
                                                        DateTime.now()),
                                                '${item.main!.temp!.round()}°C',
                                                item.weather[0].main!),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                  // Bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                      color: AppColors.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.currentDayForecast.name!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                DateFormatter.format(DateTime.now()),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showLocationBottomSheet(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.secondary,
                              ),
                              child: Icon(
                                Icons.settings,
                                size: 24,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildWeatherInfo(
      BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 34),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400, color: AppColors.textPrimary),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildForecastItem(BuildContext context, String time, String meridiem,
      String temp, String weather) {
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
            text: TextSpan(
                text: time,
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: ' $meridiem',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 11))
                ]),
          ),
          const SizedBox(height: 5),
          Image.asset(
            weather.toIconPath,
            width: 30,
          ),
          const SizedBox(height: 5),
          Text(
            temp,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  String _formatDay(String day) {
    final now = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    if (day == DateFormatter.getDay(now)) {
      return 'Today';
    } else if (day == DateFormatter.getDay(tomorrow)) {
      return 'Tomorrow';
    } else {
      return day;
    }
  }

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      backgroundColor: AppColors.secondary,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 59,
                height: 7,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    'Tangerang',
                    'Jakarta',
                    'Padang',
                    'Bandung',
                    'Surabaya',
                    'Bali',
                    'Makassar',
                    'Manado',
                    'Medan',
                    'Semarang',
                    'Yogyakarta',
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
                              _cityPicked = city;
                              context
                                  .read<WeatherBloc>()
                                  .add(GetWeather(city: city));
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
