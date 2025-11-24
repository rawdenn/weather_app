// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/material.dart';

// Future<void> getCurrentLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // 1. Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Location services are disabled.')),
//     );
//     return;
//   }

//   // 2. Check permission
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permission denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location permission denied.')),
//       );
//       return;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are permanently denied
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text(
//           'Location permissions are permanently denied. You can enable them in settings.',
//         ),
//       ),
//     );
//     return;
//   }

//   // 3. Get the current position
//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );

//   setState(() {
//     locationInput =
//         "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";
//   });
// }
