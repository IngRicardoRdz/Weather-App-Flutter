import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

// * Models
import 'package:wheater_app/src/models/weather.model.dart' as weathermodel;
import 'package:wheater_app/src/models/weatherList.model.dart'
    as weathermodellist;

class WeatherProvider extends ChangeNotifier {
  weathermodel.WeatherModel? dataWeather;
  weathermodellist.WeatherModelList? dataWeatherList;

  bool isLoading = false;

  WeatherProvider() {
    _geolocation();
  }

  final _apiToday = 'api.openweathermap.org';
  final _apiDays = 'api.openweathermap.org';

  var params = {
    'lat': '',
    'lon': '',
    'appid': '8f3cd72b9aa7f90ca7d26858c7253c81',
    'units': 'metric',
    'lang': 'es',
  };

  _geolocation() async {
    isLoading = true;
    notifyListeners();
    try {
      final position = await Geolocator.getCurrentPosition();
      params['lat'] = position.latitude.toString();
      params['lon'] = position.longitude.toString();

      _getWeatherByLocation();
    } catch (e) {
      return;
    }
  }

  // * Get today weather by geolocation
  _getWeatherByLocation() async {
    var url = Uri.https(_apiToday, '/data/2.5/weather', params);
    final resp = await http.get(url);

    final weather = weathermodel.weatherModelFromJson(resp.body);

    dataWeather = weather;

    await _getWeatherDays();
  }

  // * Get 5 days / 3 hour forecast weather by geolocation
  _getWeatherDays() async {
    var url = Uri.https(_apiDays, '/data/2.5/forecast', params);
    final resp = await http.get(url);

    final weatherList = weathermodellist.weatherModelListFromJson(resp.body);

    dataWeatherList = weatherList;

    isLoading = false;
    notifyListeners();
  }

  updateData() => _geolocation();
}
