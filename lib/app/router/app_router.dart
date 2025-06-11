import 'package:flutter/material.dart';
import 'package:flutter_weather/app/router/router.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoute.home,
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoute.home,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: WeatherDashboardRoute());
          },
        ),
        GoRoute(
          path: AppRoute.weatherSearch,
          pageBuilder: (context, state) {
            final bloc = state.extra! as WeatherDashboardBloc;
            return NoTransitionPage(child: WeatherSearchRoute(bloc: bloc));
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          child: Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        );
      },
    );
  }
}
