// ignore_for_file: non_constant_identifier_names

class Weather {
  final String cityName;
  final double temperature;
  final String Condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.Condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      Condition: json['weather'][0]['main'],
    );
  }
}
