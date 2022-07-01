import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_holdout/weather/domain/weather_repository.dart';
import 'package:my_holdout/weather/domain/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(this._weatherRepository) : super(WeatherInitial());

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeather) {
      try {
        yield WeatherLoading();
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkException {
        yield WeatherError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
