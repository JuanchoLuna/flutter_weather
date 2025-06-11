import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherDashboardRoute extends StatelessWidget {
  const WeatherDashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherDashboardBloc(
        weatherRepository: context.read<WeatherRepository>(),
      )..add(
          const WeatherDashboardLoadEvent(),
        ),
      child: const WeatherDashboardView(),
    );
  }
}
