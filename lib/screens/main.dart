import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_randomizer/widgets/balance.dart';
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

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          // Main title
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
          ),
          // All text
          bodyMedium: GoogleFonts.merriweather(
            fontSize: 20,
          ),
          // Expansion names
          labelLarge: GoogleFonts.merriweather(
            fontSize: 20,
          ),
        ),

        // scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color.fromARGB(255, 171, 186, 124),
                // Color.fromARGB(150, 171, 186, 124),

                // Color.fromARGB(255, 191, 211, 131),
                // Color.fromARGB(200, 124, 138, 78),

                Color.fromARGB(255, 246, 206, 96),
                Color.fromARGB(200, 211, 190, 131),
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.transparent,
            // backgroundColor: const Color.fromARGB(150, 171, 186, 124),
          ),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BalanceWidget(),
                  SizedBox(height: 80, child: RandomizerResult()),
                  FactionsFilter(),
                  PlayersWidget()
                ]),
          ),
        ),
      ),
    );
  }
}
