import 'package:flutter/material.dart';
import 'weather_service.dart';

class TodayPage extends StatelessWidget {
  final WeatherData? weather;
  final Color textColor; // Add this
  const TodayPage({super.key, required this.weather, required this.textColor});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Center(child: Text("No weather data yet", style: TextStyle(color: textColor)));
    }

    final today = DateTime.now();

    // Filter only hours for today
    final todayHours = weather!.hourly.where((hourData) {
      try {
        final hourDate = DateTime.parse(hourData.time.replaceFirst(' ', 'T'));
        return hourDate.year == today.year &&
            hourDate.month == today.month &&
            hourDate.day == today.day;
      } catch (e) {
        return false; // skip invalid dates
      }
    }).toList();

    if (todayHours.isEmpty) {
      return Center(child: Text("No hourly data for today", style: TextStyle(color: textColor)));
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
            itemCount: todayHours.length,
            itemBuilder: (context, index) {
              final hourData = todayHours[index];
              final hourDate = DateTime.parse(hourData.time.replaceFirst(' ', 'T'));
              final hourString = "${hourDate.hour.toString().padLeft(2,'0')}:${hourDate.minute.toString().padLeft(2,'0')}";

              return ListTile(
                leading: Text(hourString, style: TextStyle(color: textColor)),
                title: Text("${hourData.temperature} °C", style: TextStyle(color: textColor)),
                subtitle: Text(hourData.description, style: TextStyle(color: textColor)),
                trailing: Text("${hourData.windSpeed} km/h", style: TextStyle(color: textColor)),
              );
            },
          ),
        ),
      ],
    );
  }
}
