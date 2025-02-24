import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Tambahkan ini
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      home: WorldClockApp(),
    );
  }
}

class WorldClockApp extends StatefulWidget {
  @override
  _WorldClockAppState createState() => _WorldClockAppState();
}

class _WorldClockAppState extends State<WorldClockApp> {
  bool isEnglish = true;

  Map<String, Duration> timeZones = {
    'Indonesia': Duration(hours: 7),
    'Amerika': Duration(hours: -5),
    'Jepang': Duration(hours: 9),
    'Arab': Duration(hours: 3),
    'Jerman': Duration(hours: 1),
  };

  String getFormattedTime(Duration offset) {
    return DateFormat('HH:mm:ss').format(DateTime.now().toUtc().add(offset));
  }

  Color getBackgroundColor() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return Colors.blueAccent; // Pagi
    } else if (hour >= 12 && hour < 17) {
      return Colors.orangeAccent; // Sore
    } else {
      return Colors.black87; // Malam
    }
  }

  List<Color> getGradientColors() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return [Colors.blue.shade300, Colors.blue.shade900]; // Pagi
    } else if (hour >= 12 && hour < 17) {
      return [Colors.orange.shade300, Colors.orange.shade900]; // Sore
    } else {
      return [Colors.black87, Colors.black54]; // Malam
    }
  }

  String getBackgroundImage() {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return 'assets/images/pagi.jpg'; // Pagi (06:00 - 11:59)
    } else if (hour >= 12 && hour < 18) {
      return 'assets/images/sore.jpg'; // Sore (12:00 - 17:59)
    } else {
      return 'assets/images/malam.jpg'; // Malam (18:00 - 05:59)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage(getBackgroundImage()), // Tambahkan background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Biar gambar nggak terlalu terang
              BlendMode.darken,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: getGradientColors(),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              isEnglish ? "World Clock" : "Jam Dunia",
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'Aqua',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: timeZones.length,
                itemBuilder: (context, index) {
                  String country = timeZones.keys.elementAt(index);
                  return Card(
                    color: Colors.white.withOpacity(0.2),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        country,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Aqua',
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        getFormattedTime(timeZones[country]!),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Aqua',
                          color: Colors.white70,
                        ),
                      ),
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                isEnglish ? "Switch to Bahasa" : "Ubah ke English",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Aqua',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
