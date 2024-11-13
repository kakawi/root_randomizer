import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_randomizer/widgets/factions_filter.dart';
import 'package:root_randomizer/widgets/players.dart';
import 'package:root_randomizer/widgets/randomizer_result.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = "Root Randomizer";
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          // ···
          brightness: Brightness.light,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80, child: RandomizerResult()),
                FactionsFilter(),
                PlayersWidget()
              ]),
        ),
      ),
    );
  }
}
