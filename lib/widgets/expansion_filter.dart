import 'package:flutter/material.dart';
import 'package:root_randomizer/widgets/faction_filter.dart';
import 'package:root_randomizer/widgets/faction_icon.dart';

class ExpansionFilter extends StatelessWidget {
  const ExpansionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Base game'),
        ),
        Expanded(
            child: Row(
          children: [
            FactionFilter(
                factionIcon: FactionIcon(faction: Factions.marquiseDeCat),
                onTap: () {},
                onLongPressed: () {}),
            FactionFilter(
                factionIcon: FactionIcon(faction: Factions.eerieDynasty),
                onTap: () {},
                onLongPressed: () {}),
            FactionFilter(
                factionIcon: FactionIcon(faction: Factions.woodlandAlliance),
                onTap: () {},
                onLongPressed: () {}),
            FactionFilter(
                factionIcon: FactionIcon(faction: Factions.vagabond),
                onTap: () {},
                onLongPressed: () {}),
          ],
        )),
      ],
    ));
  }
}
