import 'package:flutter/material.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:weather_repository/weather_repository.dart';

class FullCityWeatherCard extends StatelessWidget {
  const FullCityWeatherCard({required this.weather, super.key});
  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final sys = weather.sys;
    final main = weather.main;
    final wind = weather.wind;
    final rain = weather.rain;
    final clouds = weather.clouds;
    final info =
        weather.weather?.isNotEmpty == true ? weather.weather!.first : null;

    // Detectar día/noche
    final dt = weather.dt;
    bool isNight = false;
    if (sys != null && dt != null) {
      isNight = dt < sys.sunrise! || dt > sys.sunset!;
    }
    final cardColor = isNight ? Colors.black : Colors.white;
    final textColor = isNight ? Colors.white : Colors.black;

    // Helpers
    String celsius(double? k) =>
        k != null ? '${(k - 273.15).toStringAsFixed(1)}°C' : '--';
    String timeOf(int? ts) => ts != null
        ? TimeOfDay.fromDateTime(
                DateTime.fromMillisecondsSinceEpoch(ts * 1000).toLocal())
            .format(context)
        : '--';
    final iconUrl = info != null
        ? 'https://openweathermap.org/img/wn/${info.icon}@2x.png'
        : null;

    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    weather.name ?? '—',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 8),
                  if (iconUrl != null)
                    Image.network(iconUrl, width: 60, height: 60),
                  const SizedBox(height: 4),
                  Text(
                    celsius(main?.temp),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: textColor),
                  ),
                ],
              ),
            ),

            const Divider(height: 32),
            DetailRow(
              icon: Icons.thermostat_outlined,
              label: 'Temp. Mín',
              value: celsius(main?.tempMin),
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.thermostat,
              label: 'Temp. Máx',
              value: celsius(main?.tempMax),
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.opacity,
              label: 'Humedad',
              value: main?.humidity != null ? '${main!.humidity}%' : '--',
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.compress,
              label: 'Presión',
              value: main?.pressure != null ? '${main!.pressure} hPa' : '--',
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.air,
              label: 'Viento',
              value: wind?.speed != null
                  ? '${wind!.speed!.toStringAsFixed(1)} m/s'
                  : '--',
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.grain,
              label: 'Nubes',
              value: clouds?.all != null ? '${clouds!.all}%' : '--',
              textColor: textColor,
            ),
            DetailRow(
              icon: Icons.umbrella,
              label: 'Lluvia (1h)',
              value: rain?.oneHour != null
                  ? '${rain!.oneHour!.toStringAsFixed(1)} mm'
                  : '--',
              textColor: textColor,
            ),
            if (sys != null) ...[
              DetailRow(
                icon: Icons.wb_sunny,
                label: 'Salida Sol',
                value: timeOf(sys.sunrise),
                textColor: textColor,
              ),
              DetailRow(
                icon: Icons.nights_stay,
                label: 'Puesta Sol',
                value: timeOf(sys.sunset),
                textColor: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
