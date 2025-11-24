import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'CurrentlyPage.dart';
import 'TodayPage.dart';
import 'WeeklyPage.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String locationInput = "";
  String? errorMessage;
  String? coordinates;

  Future<void> fetchLocation() async {
    setState(() {
      errorMessage = null;
      coordinates = null;
    });

    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      setState(() {
        errorMessage = "Location permissions are denied.";
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        errorMessage =
            "Location permissions are permanently denied. Enable them in settings.";
      });
      return;
    }

    // Get coordinates
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      coordinates = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (errorMessage != null) {
      bodyContent = Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    } else if (coordinates != null) {
      bodyContent = Center(
        child: Text(
          "Coordinates:\n$coordinates",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      bodyContent = TabBarView(
        controller: _tabController,
        children: [
          CurrentlyPage(location: locationInput),
          TodayPage(location: locationInput),
          WeeklyPage(location: locationInput),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    locationInput = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintText: "Search city...",
                  hintStyle: TextStyle(color: Colors.grey[300]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.location_on, color: Colors.white),
              onPressed: () => fetchLocation(),
            ),
          ],
        ),
      ),

      body: bodyContent,

      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[900],
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.wb_sunny), text: "Currently"),
            Tab(icon: Icon(Icons.today), text: "Today"),
            Tab(icon: Icon(Icons.calendar_view_week), text: "Weekly"),
          ],
        ),
      ),
    );
  }
}
