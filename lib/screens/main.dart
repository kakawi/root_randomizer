import 'package:flutter/material.dart';
import 'package:root_randomizer/widgets/factions_filter.dart';
import 'package:root_randomizer/widgets/randomizer_result.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Root randomiser')),
        body: Column(children: [RandomizerResult(), FactionsFilter()]),
      ),
    );
  }
}
