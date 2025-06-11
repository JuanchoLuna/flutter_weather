part of 'weather_dashboard_bloc.dart';

abstract class WeatherDashboardEvent extends Equatable {
  const WeatherDashboardEvent();
}

final class WeatherDashboardLoadEvent extends WeatherDashboardEvent {
  const WeatherDashboardLoadEvent();

  @override
  List<Object> get props => [];
}

final class WeatherDashboardRefreshEvent extends WeatherDashboardEvent {
  const WeatherDashboardRefreshEvent();

  @override
  List<Object> get props => [];
}

final class WeatherDashboardLocationSearched extends WeatherDashboardEvent {
  const WeatherDashboardLocationSearched();

  @override
  List<Object> get props => [];
}

final class WeatherDashboardPlaceSearched extends WeatherDashboardEvent {
  const WeatherDashboardPlaceSearched({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

final class WeatherDashboardCitySelected extends WeatherDashboardEvent {
  const WeatherDashboardCitySelected(
      {required this.cityName, required this.id});

  final String cityName;
  final String id;

  @override
  List<Object> get props => [
        cityName,
        id,
      ];
}

final class WeatherDashboardSearchUnselected extends WeatherDashboardEvent {
  const WeatherDashboardSearchUnselected();

  @override
  List<Object> get props => [];
}
