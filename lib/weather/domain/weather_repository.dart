import 'dart:math';

import 'package:my_holdout/weather/domain/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();

      if (random.nextBool()) {
        throw NetworkException();
      }

      return Weather(cityName: cityName,
          temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble());
    });
  }
}

class NetworkException implements Exception {}