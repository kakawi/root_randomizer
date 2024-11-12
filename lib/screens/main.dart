import 'package:flutter/material.dart';
import 'package:root_randomizer/widgets/factions_filter.dart';
import 'package:root_randomizer/widgets/players.dart';
import 'package:root_randomizer/widgets/randomizer_result.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = "Root Randomizer";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80, child: const RandomizerResult()),
                const FactionsFilter(),
                const PlayersWidget()
              ]),
        ),
      ),
    );
  }
}
