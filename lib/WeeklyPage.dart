import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeeklyPage extends StatelessWidget {
  final WeatherData? weather;
  final Color textColor; // Add this
  const WeeklyPage({super.key, required this.weather, required this.textColor});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Center(child: Text("No weather data yet", style: TextStyle(color: textColor)));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "${weather!.city}, ${weather!.region.isNotEmpty ? '${weather!.region}, ' : ''}${weather!.country}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: weather!.daily.length,
            itemBuilder: (context, index) {
              final day = weather!.daily[index];
              return ListTile(
                leading: Text(day.date, style: TextStyle(color: textColor)),
                title: Text(
                  "Min: ${day.minTemp} °C, Max: ${day.maxTemp} °C",
                  style: TextStyle(color: textColor),
                ),
                subtitle: Text(day.description, style: TextStyle(color: textColor)),
              );
            },
          ),
        ),
      ],
    );
  }
}
