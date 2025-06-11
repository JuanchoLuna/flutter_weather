part of 'weather_dashboard_bloc.dart';

enum WeatherDashboardStatus {
  initial,
  loading,
  loaded,
  error,
  placeSearching,
  placeSearched,
  locationServiceLoaded,
  locationService;

  bool get isLocationService => this == WeatherDashboardStatus.locationService;
  bool get isLocationServiceLoaded =>
      this == WeatherDashboardStatus.locationServiceLoaded;
  bool get isPlaceSearching => this == WeatherDashboardStatus.placeSearching;
  bool get isPlaceSearched => this == WeatherDashboardStatus.placeSearched;
}

final class WeatherDashboardState extends Equatable {
  const WeatherDashboardState({
    required this.status,
    required this.weatherData,
    required this.userLat,
    required this.userLon,
    required this.userWeather,
    required this.query,
    required this.predictions,
    required this.selected,
    this.selectedWeather,
  });

  const WeatherDashboardState.initial()
      : this(
          status: WeatherDashboardStatus.initial,
          weatherData: const <WeatherResponse>[],
          userLat: '',
          userLon: '',
          userWeather: null,
          query: '',
          predictions: null,
          selected: null,
          selectedWeather: null,
        );

  final WeatherDashboardStatus status;
  final List<WeatherResponse> weatherData;
  final String userLat;
  final String userLon;
  final WeatherResponse? userWeather;
  final String query;
  final FindAutocompletePredictionsResponse? predictions;
  final String? selected;
  final WeatherResponse? selectedWeather;

  WeatherDashboardState copyWith({
    WeatherDashboardStatus? status,
    List<WeatherResponse>? weatherData,
    String? userLat,
    String? userLon,
    WeatherResponse? userWeather,
    String? query,
    FindAutocompletePredictionsResponse? predictions,
    String? selected,
    WeatherResponse? selectedWeather,
  }) {
    return WeatherDashboardState(
      status: status ?? this.status,
      weatherData: weatherData ?? this.weatherData,
      userLat: userLat ?? this.userLat,
      userLon: userLon ?? this.userLon,
      userWeather: userWeather ?? this.userWeather,
      query: query ?? this.query,
      predictions: predictions ?? this.predictions,
      selected: selected ?? this.selected,
      selectedWeather: selectedWeather ?? this.selectedWeather,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weatherData,
        userLat,
        userLon,
        userWeather,
        query,
        predictions,
        selected,
        selectedWeather,
      ];
}
