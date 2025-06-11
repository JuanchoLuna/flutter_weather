import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_ui/weather_ui.dart';

class DashboardFloatingButton extends StatelessWidget {
  const DashboardFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context
            .read<WeatherDashboardBloc>()
            .add(const WeatherDashboardLocationSearched());
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: const Icon(Icons.my_location),
    );
  }
}

class UserLocationWeather extends StatelessWidget {
  const UserLocationWeather({
    super.key,
    required this.weather,
  });

  final WeatherResponse? weather;
  @override
  Widget build(BuildContext context) {
    if (weather != null) {
      DateTime _toLocal(int ts) =>
          DateTime.fromMillisecondsSinceEpoch(ts * 1000).toLocal();
      String _formatTime(int? ts) => ts != null
          ? TimeOfDay.fromDateTime(_toLocal(ts)).format(context)
          : '--';

      final sys = weather!.sys;
      final main = weather!.main;
      final wind = weather!.wind;
      final rain = weather!.rain;
      final clouds = weather!.clouds;
      final info =
          weather!.weather?.isNotEmpty == true ? weather!.weather!.first : null;

      // Temperaturas en Celsius
      String _celsius(double? k) =>
          k != null ? '${(k - 273.15).toStringAsFixed(1)}°C' : '--';

      // URL icono OpenWeather
      final iconUrl = info != null
          ? 'https://openweathermap.org/img/wn/${info.icon}@2x.png'
          : null;

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Text(
                  'Estas aqui',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  weather!.name ?? 'Ubicación desconocida',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconUrl != null)
                      Image.network(iconUrl, width: 40, height: 40),
                    const SizedBox(width: 8),
                    Text(
                      _celsius(main?.temp),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.thermostat_outlined,
                  label: 'Temp. Mínima',
                  value: _celsius(main?.tempMin),
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.thermostat,
                  label: 'Temp. Máxima',
                  value: _celsius(main?.tempMax),
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.opacity,
                  label: 'Humedad',
                  value: main?.humidity != null ? '${main!.humidity}%' : '--',
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.compress,
                  label: 'Presión',
                  value:
                      main?.pressure != null ? '${main!.pressure} hPa' : '--',
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.air,
                  label: 'Viento',
                  value: wind?.speed != null
                      ? '${wind!.speed!.toStringAsFixed(1)} m/s'
                      : '--',
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.grain,
                  label: 'Nubes',
                  value: clouds?.all != null ? '${clouds!.all}%' : '--',
                  textColor: Colors.black,
                ),
                DetailRow(
                  icon: Icons.umbrella,
                  label: 'Lluvia (1h)',
                  value: rain?.oneHour != null
                      ? '${rain!.oneHour!.toStringAsFixed(1)} mm'
                      : '--',
                  textColor: Colors.black,
                ),
                if (sys != null) ...[
                  DetailRow(
                    icon: Icons.wb_sunny,
                    label: 'Salida Sol',
                    value: _formatTime(sys.sunrise),
                    textColor: Colors.black,
                  ),
                  DetailRow(
                    icon: Icons.nights_stay,
                    label: 'Puesta Sol',
                    value: _formatTime(sys.sunset),
                    textColor: Colors.black,
                  ),
                ],
                const SizedBox(height: 24),
                Lottie.asset(
                  'packages/weather_ui/assets/animations/location.json',
                  width: context.screenWidth,
                  height: context.screenHeight * 0.2,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Lottie.asset(
        'packages/weather_ui/assets/animations/loading.json',
        width: context.screenWidth,
        height: context.screenHeight * 0.25,
      );
    }
  }
}
