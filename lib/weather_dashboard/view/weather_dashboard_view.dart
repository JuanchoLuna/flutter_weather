import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';

import 'package:lottie/lottie.dart';
import 'package:weather_ui/weather_ui.dart';

class WeatherDashboardView extends StatelessWidget {
  const WeatherDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherDashboardBloc, WeatherDashboardState>(
      listener: (context, state) {
        if (state.status == WeatherDashboardStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Center(child: Text('Ocurrió un error al cargar la información del clima.')),
            ),
          );
        } else if (state.status == WeatherDashboardStatus.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Información cargada correctamente!')),
            ),
          );
        }
      },
      child: const Scaffold(
        floatingActionButton: DashboardFloatingButton(),
        appBar: WeatherAppBar(),
        body: _WeatherDashboardWidget(),
      ),
    );
  }
}

class _WeatherDashboardWidget extends StatelessWidget {
  const _WeatherDashboardWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.select((WeatherDashboardBloc bloc) => bloc.state);

    return BlocListener<WeatherDashboardBloc, WeatherDashboardState>(
      listener: (context, state) {
        if (state.status.isLocationServiceLoaded) {
          showDialog<void>(
            context: context,
            builder: (_) {
              return UserLocationWeather(
                weather: state.userWeather,
              );
            },
          );
        }
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(
              'packages/weather_ui/assets/animations/fondo_bajo.json',
              width: context.screenWidth,
              height: context.screenHeight * 0.25,
            ),
          ),
          Column(
            children: [
              if (state.weatherData.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.weatherData.length,
                    itemBuilder: (context, index) {
                      final weather = state.weatherData[index];
                      return ExpandableCityCard(weather: weather);
                    },
                  ),
                )
              else
                Center(
                  child: Lottie.asset(
                    'packages/weather_ui/assets/animations/loading.json',
                    width: context.screenWidth,
                    height: context.screenHeight * 0.2,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
