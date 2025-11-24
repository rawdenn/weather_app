import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  final String location;
  const TodayPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // centers the column vertically
        children: [
          Text(
            "Today",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            location.isEmpty ? '' : location,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
