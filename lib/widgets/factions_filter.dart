import 'package:flutter/material.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/widgets/expansion_filter.dart';

class FactionsFilter extends StatelessWidget {
  const FactionsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        ExpansionFilter(
          expansionName: "Base game",
          factions: [
            Factions.marquiseDeCat,
            Factions.eerieDynasty,
            Factions.woodlandAlliance,
            Factions.vagabond,
          ],
        ),
      ],
    ));
  }
}
