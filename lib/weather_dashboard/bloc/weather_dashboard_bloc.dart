import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_ui/weather_ui.dart';

part 'weather_dashboard_event.dart';
part 'weather_dashboard_state.dart';

class WeatherDashboardBloc
    extends Bloc<WeatherDashboardEvent, WeatherDashboardState> {
  WeatherDashboardBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherDashboardState.initial()) {
    on<WeatherDashboardLoadEvent>(_onWeatherDashboardLoad);
    on<WeatherDashboardRefreshEvent>(_onWeatherDashboardRefresh);
    on<WeatherDashboardLocationSearched>(_onWeatherDashboardLocationSearched);
    on<WeatherDashboardPlaceSearched>(_onWeatherDashboardPlaceSearched);
    on<WeatherDashboardCitySelected>(_onWeatherDashboardCitySelected);
    on<WeatherDashboardSearchUnselected>(_onWeatherDashboardSearchUnselected);
  }

  final WeatherRepository _weatherRepository;
  final LocationService locationService = LocationService();
  final _places = FlutterGooglePlacesSdk(googlePlaceApi);

  FutureOr<void> _onWeatherDashboardLoad(
    WeatherDashboardLoadEvent event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    emit(state.copyWith(status: WeatherDashboardStatus.loading));

    try {
      final prefs = await SharedPreferences.getInstance();

      // 1) Intentamos leer la lista de ciudades guardada
      final citiesJson = prefs.getString('cityList');
      final weatherData = prefs.getString('weatherData');
      final List<String> cityNames;

      if (citiesJson != null) {
        final decoded = json.decode(citiesJson) as List<dynamic>;
        cityNames = decoded.cast<String>();
      } else {
        // Lista por defecto si no existe
        cityNames = [
          'Montevideo',
          'Buenos Aires',
          'London',
          'Munich',
          'Sao Paulo',
        ];
      }

      //Controla conexión a internet
      final isConnected =
          await InternetConnectionChecker.instance.hasConnection;

      var weatherList = <WeatherResponse>[];

      if (isConnected) {
        weatherList = await Future.wait(
          cityNames.map(
            (name) => _weatherRepository.getCurrentWeatherForCityName(
              cityName: name,
            ),
          ),
        );
      } else {
        if (weatherData!.isNotEmpty || weatherData != '') {
          // final weatherOnLocalDevice = jsonDecode(weatherData);
        }
      }

      if (citiesJson == null || cityNames.isEmpty && weatherList.isNotEmpty) {
        final weatherJsonList = weatherList.map((w) => w.toJson()).toList();
        await prefs.setString('cityList', json.encode(cityNames));
        await prefs.setString(
          'weatherData',
          json.encode(weatherJsonList),
        );
      }

      emit(
        state.copyWith(
          status: WeatherDashboardStatus.loaded,
          weatherData: weatherList,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: WeatherDashboardStatus.error),
      );
    }
  }

  FutureOr<void> _onWeatherDashboardRefresh(
    WeatherDashboardRefreshEvent event,
    Emitter<WeatherDashboardState> emit,
  ) {}

  FutureOr<void> _onWeatherDashboardLocationSearched(
    WeatherDashboardLocationSearched event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    emit(state.copyWith(status: WeatherDashboardStatus.locationService));
    try {
      final position = await locationService.getCurrentPosition();
      final lat = position.latitude.toString();
      final lon = position.longitude.toString();

      final userWeather = await _weatherRepository
          .getCurrentWeatherForLatAndLon(lat: lat, lon: lon);

      emit(
        state.copyWith(
          status: WeatherDashboardStatus.locationServiceLoaded,
          userLat: lat,
          userLon: lon,
          userWeather: userWeather,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(status: WeatherDashboardStatus.error),
      );
    }
  }

  Future<void> _onWeatherDashboardPlaceSearched(
    WeatherDashboardPlaceSearched event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    final query = event.query.trim();
    emit(state.copyWith(status: WeatherDashboardStatus.placeSearching));
    if (query.isEmpty) {
      emit(state.copyWith(
          status: WeatherDashboardStatus.placeSearched, selected: ''));
      return;
    }
    try {
      final predictions = await _places.findAutocompletePredictions(query);
      emit(
        state.copyWith(
          status: WeatherDashboardStatus.placeSearched,
          predictions: predictions,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: WeatherDashboardStatus.error),
      );
    }
  }

  Future<void> _onWeatherDashboardCitySelected(
    WeatherDashboardCitySelected event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    final cityName = event.cityName.trim();
    if (cityName.isEmpty) {
      emit(state.copyWith(
          status: WeatherDashboardStatus.placeSearched, selected: null));
      return;
    }

    emit(state.copyWith(
        status: WeatherDashboardStatus.loading, selected: cityName));

    try {
      // 1) Obtengo el clima para la ciudad nueva
      final newWeather = await _weatherRepository.getCurrentWeatherForCityName(
          cityName: cityName);

      emit(state.copyWith(selectedWeather: newWeather));

      // 2) Actualizo cityList en prefs
      final prefs = await SharedPreferences.getInstance();
      final citiesJson = prefs.getString('cityList');
      final List<String> cityNames = citiesJson != null
          ? (json.decode(citiesJson) as List<dynamic>).cast<String>()
          : <String>[];

      if (!cityNames.contains(cityName)) {
        cityNames.add(cityName);
        await prefs.setString('cityList', json.encode(cityNames));
      }

      // 3) Construyo la nueva lista de WeatherResponse
      final existingList = state.weatherData; // lista actual en el estado
      final updatedList = [...existingList, newWeather]; // agrego el nuevo

      // 4) Persisto weatherData completo en prefs
      final weatherJsonList = updatedList.map((w) => w.toJson()).toList();
      await prefs.setString('weatherData', json.encode(weatherJsonList));

      // 5) Emito el estado con la lista actualizada
      emit(state.copyWith(
        status: WeatherDashboardStatus.placeSearched,
        weatherData: updatedList,
      ));
    } catch (error) {
      emit(state.copyWith(status: WeatherDashboardStatus.error));
    }
  }

  void _onWeatherDashboardSearchUnselected(
    WeatherDashboardSearchUnselected event,
    Emitter<WeatherDashboardState> emit,
  ) {
    emit(state.copyWith(
      status: WeatherDashboardStatus.placeSearched,
      selected: '',
    ));
  }
}
