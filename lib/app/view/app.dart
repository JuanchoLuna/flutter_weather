import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/app/router/app_router.dart';
import 'package:flutter_weather/l10n/l10n.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App({required this.weatherRepository, super.key});

  final WeatherRepository weatherRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(value: weatherRepository),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter.router(),
      ),
    );
  }
}
