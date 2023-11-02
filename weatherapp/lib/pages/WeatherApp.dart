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
  TextEditingController _cityNameController = TextEditingController();
  bool _showCurrentLocationWeather = true;
  String _locationName = "";
  _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _showCurrentLocationWeather = false;
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchCurrentLocationWeather() async {
    try {
      String currentCity = await _weatherService.getCurrentCity();
      if (currentCity == "Bouzareah") {
        currentCity = "Bouzarea";
      }
      final weather = await _weatherService.getWeather(currentCity);
      setState(() {
        _weather = weather;
        _showCurrentLocationWeather = true;
        _locationName = currentCity;
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
    _fetchCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityNameController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _fetchWeather(value);
                } else {
                  _fetchCurrentLocationWeather();
                }
              },
              decoration: InputDecoration(
                hintText: "dekhel city li thws tchof lweather taeha hbb",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
            ),
            if (_weather != null)
              Column(
                children: [
                  Text(
                    _showCurrentLocationWeather
                        ? _locationName
                        : _weather!.cityName,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Lottie.asset(
                    getWeatherAnimation(_weather!.Condition),
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    '${_weather!.temperature.round()}°C',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_weather!.Condition}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
