import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:weather_ui/weather_ui.dart';

class WeatherSearchRoute extends StatelessWidget {
  const WeatherSearchRoute({required this.bloc, super.key});

  final WeatherDashboardBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const WeatherSearchView(),
    );
  }
}

class WeatherSearchView extends StatelessWidget {
  const WeatherSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherDashboardBloc, WeatherDashboardState>(
      listener: (context, state) {
        if (state.status == WeatherDashboardStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                  child: Text(
                      'Ocurrió un error al cargar la información del clima.')),
            ),
          );
        } else if (state.status == WeatherDashboardStatus.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Center(child: Text('Información cargada correctamente!')),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: const WeatherSearchAppBar(),
          body: Column(
            children: [
              PlaceSearchInput(onPlaceSelected: (prediction) {
                context.read<WeatherDashboardBloc>().add(
                      WeatherDashboardCitySelected(
                        cityName: prediction.primaryText,
                        id: prediction.placeId,
                      ),
                    );
              }),
            ],
          )),
    );
  }
}

typedef OnPlaceSelected = void Function(AutocompletePrediction);

class PlaceSearchInput extends StatelessWidget {
  /// callback que recibirá la predicción elegida
  final OnPlaceSelected onPlaceSelected;

  const PlaceSearchInput({
    Key? key,
    required this.onPlaceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeatherDashboardBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: WEATHERSpacing.lg, vertical: WEATHERSpacing.md),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Busca la ciudad',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
            onChanged: (q) => context
                .read<WeatherDashboardBloc>()
                .add(WeatherDashboardPlaceSearched(query: q)),
          ),
          const SizedBox(height: 8),
          if (state.selectedWeather == null || state.selected!.isEmpty) ...[
            BlocBuilder<WeatherDashboardBloc, WeatherDashboardState>(
              builder: (context, state) {
                if (state.predictions == null ||
                    state.predictions!.predictions.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.predictions!.predictions.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final p = state.predictions!.predictions[i];
                      return ListTile(
                        title: Text(p.fullText),
                        onTap: () => onPlaceSelected(p),
                      );
                    },
                  ),
                );
              },
            ),
          ] else ...[
            FullCityWeatherCard(weather: state.selectedWeather!),
          ],
        ],
      ),
    );
  }
}
