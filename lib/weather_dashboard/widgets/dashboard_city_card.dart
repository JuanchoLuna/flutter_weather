import 'package:flutter/material.dart';
import 'package:weather_repository/weather_repository.dart';

class ExpandableCityCard extends StatefulWidget {
  final WeatherResponse weather;
  const ExpandableCityCard({Key? key, required this.weather}) : super(key: key);

  @override
  State<ExpandableCityCard> createState() => _ExpandableCityCardState();
}

class _ExpandableCityCardState extends State<ExpandableCityCard> {
  bool _isExpanded = false;
  static const double _collapsedHeight = 80;
  static const double _expandedHeight = 250; 

  @override
  Widget build(BuildContext context) {
    final sys = widget.weather.sys;
    final dt = widget.weather.dt;
    bool isNight = false;
    if (sys != null && dt != null) {
      final sunrise = sys.sunrise!;
      final sunset = sys.sunset!;
      isNight = dt < sunrise || dt > sunset;
    }

    final cardColor = isNight ? Colors.black : Colors.white;
    final textColor = isNight ? Colors.white : Colors.black;

    // Temperatura en Celsius
    final kelvin = widget.weather.main?.temp;
    final tempC = kelvin != null ? (kelvin - 273.15).toStringAsFixed(1) : '--';

    // Icono del clima
    final iconCode = widget.weather.weather?.isNotEmpty == true
        ? widget.weather.weather!.first.icon
        : null;
    final iconUrl = iconCode != null
        ? 'https://openweathermap.org/img/wn/$iconCode@2x.png'
        : null;

    // Datos extra
    final wind = widget.weather.wind;
    final main = widget.weather.main;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _isExpanded ? _expandedHeight : _collapsedHeight,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          color: cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.weather.name ?? '—',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                      ),
                    ),
                    if (iconUrl != null)
                      Image.network(iconUrl, width: 40, height: 40),
                    const SizedBox(width: 8),
                    Text(
                      '$tempC°C',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          DetailRow(
                            icon: Icons.thermostat_outlined,
                            label: 'Temp. Mín',
                            value: main?.tempMin != null
                                ? '${(main!.tempMin! - 273.15).toStringAsFixed(1)}°C'
                                : '--',
                            textColor: textColor,
                          ),
                          DetailRow(
                            icon: Icons.thermostat,
                            label: 'Temp. Máx',
                            value: main?.tempMax != null
                                ? '${(main!.tempMax! - 273.15).toStringAsFixed(1)}°C'
                                : '--',
                            textColor: textColor,
                          ),
                          DetailRow(
                            icon: Icons.air,
                            label: 'Viento',
                            value: wind != null
                                ? '${wind.speed?.toStringAsFixed(1)} m/s'
                                : '--',
                            textColor: textColor,
                          ),
                          DetailRow(
                            icon: Icons.opacity,
                            label: 'Humedad',
                            value: main?.humidity != null
                                ? '${main!.humidity}%'
                                : '--',
                            textColor: textColor,
                          ),
                          DetailRow(
                            icon: Icons.compress,
                            label: 'Presión',
                            value: main?.pressure != null
                                ? '${main!.pressure} hPa'
                                : '--',
                            textColor: textColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;

  const DetailRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
