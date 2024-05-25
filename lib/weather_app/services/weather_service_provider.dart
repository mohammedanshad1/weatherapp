import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weatherapp/weather_app/model/weather_response_model.dart';
import 'package:http/http.dart' as http;

import '../secrets/apiendpoint.dart';

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _error = "";

  String get error => _error;

  Future<void> fetchWeatherDataByCity(String city) async {
    _isLoading = true;
    _error = "";

    ///https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=40228e3078cc75c6b9ac266d59da9fec&units=metric
    try {
      final apiUrl =
          "${APIEndpoints().cityUrl}${city}&appid=${APIEndpoints().apiKey}${APIEndpoints().unit}";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        _weather=WeatherModel.fromJson(data);
        print(_weather);
        notifyListeners();

      }else{

        _error="Failed to Load Data";
      }
    } catch (e) {
      _error="Failed to load data $e";
    }finally{

      _isLoading=false;
      notifyListeners();
    }
  }
}
