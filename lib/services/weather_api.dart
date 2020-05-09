import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:srl/config.dart';
import 'package:srl/services/position.dart';
import 'package:srl/services/weather_api_models.dart';

class WeatherService {
  const WeatherService._();
  static const instance = WeatherService._();

  /// Get the latest WeatherModel
  Future<OpenWeatherOneCall> fetchWeather(
      {Position position = const Position.baltimore()}) async {
    final uri =
        Uri.parse("https://api.openweathermap.org/data/2.5/onecall").replace(
      queryParameters: {
        "lat": "${position.latitude}",
        "lon": "${position.longitude}",
        "appid": AppConfig.openWeatherApiKey,
      },
    );

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return OpenWeatherOneCall.fromJson(json);
  }
}
