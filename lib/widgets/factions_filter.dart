import 'package:flutter/material.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/widgets/expansion_filter.dart';

class FactionsFilter extends StatelessWidget {
  const FactionsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ExpansionFilter(
          expansionName: "Base game",
          factions: [
            Factions.marquiseDeCat,
            Factions.eyrieDynasty,
            Factions.woodlandAlliance,
            Factions.vagabond,
          ],
        ),
        ExpansionFilter(
          expansionName: "The Riverfolk Expansion",
          factions: [
            Factions.lizardCult,
            Factions.riverfolkCompany,
            Factions.secondVagabond,
          ],
        ),
        ExpansionFilter(expansionName: "The Underworld Expansion", factions: [
          Factions.corvidConspiracy,
          Factions.undergroundDuchy,
        ]),
        ExpansionFilter(expansionName: "The Marauder Expansion", factions: [
          Factions.lordOfTheHundreds,
          Factions.keepersInIron,
        ])
      ],
    ));
  }
}
