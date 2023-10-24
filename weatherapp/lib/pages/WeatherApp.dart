// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _weatherService = WeatherService('b8ce43127354bfb6939f837f679417dd');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? Condition) {
    if (Condition == null) return 'assets/sunny.json';
    switch (Condition.toLowerCase()) {
      case 'clouds':
        return 'assets/windy.json';
      case 'rain':
        return 'assets/partly-shower.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "loading city.."),
          Lottie.asset(getWeatherAnimation(_weather?.Condition)),
          Text('${_weather?.temperature.round()}°C'),
          Text(_weather?.Condition ?? "loading.."),
        ],
      ),
    ));
  }
}
