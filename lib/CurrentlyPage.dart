import 'package:flutter/material.dart';

class CurrentlyPage extends StatelessWidget {
  final String location;
  const CurrentlyPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // centers the column vertically
        children: [
          Text(
            "Currently",
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
