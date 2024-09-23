import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_improve/Exercices/Weather%20%20App/services/Weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService("3a88bfeccd7d6734ba4d959064a95589");
  Weather? _weather;

  // Fetch weather
  Future<void> _fetchWeather() async {
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

  // Weather animation
  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'fog':
      case 'haze':
      case 'smoke':
      case 'dust':
        return 'assets/jsons/cloud.json';
      case 'rain':
      case 'drizzle':
        return 'assets/jsons/rain.json';
      case 'thunderstorm':
        return 'assets/jsons/thunder.json';
      case 'clear':
        return 'assets/jsons/sun.json';
      default:
        return 'assets/jsons/sun.json'; // Default to sunny
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
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // City name
                Text(
                  _weather?.cityName ?? "Fetching location...",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Weather animation
                if (_weather != null)
                  Lottie.asset(
                    getWeatherAnimation(_weather!.mainCondition),
                    height: 200,
                  )
                else
                  const CircularProgressIndicator(color: Colors.blueAccent),

                const SizedBox(height: 40),

                // Temperature
                Text(
                  _weather != null
                      ? '${_weather!.temperature.round()}°C'
                      : "Loading temperature...",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 20),

                // Weather condition
                Text(
                  _weather?.mainCondition ?? "Fetching weather...",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blueGrey,
                  ),
                ),

                const Spacer(),

                // Footer with info
                Text(
                  "Powered by OpenWeather API",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
