import 'package:flutter/material.dart';
import 'weather_service.dart';
class CurrentlyPage extends StatelessWidget {
  final WeatherData? weather;
  final Color textColor; // add this
  const CurrentlyPage({super.key, required this.weather, required this.textColor});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Center(child: Text("No weather data yet", style: TextStyle(color: textColor)));
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${weather!.city}, ${weather!.region.isNotEmpty ? '${weather!.region}, ' : ''}${weather!.country}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text("${weather!.temperature} °C", style: TextStyle(fontSize: 24, color: textColor)),
          Text(weather!.description, style: TextStyle(fontSize: 18, color: textColor)),
          Text("Wind: ${weather!.windSpeed} km/h", style: TextStyle(fontSize: 16, color: textColor)),
        ],
      ),
    );
  }
}
