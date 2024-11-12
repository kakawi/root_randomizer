import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/widgets/faction_filter.dart';

class ExpansionFilter extends ConsumerWidget {
  const ExpansionFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: Column(
      children: [
        ElevatedButton(
          onPressed: () {
            final notifier = ref.read(factionsFilterProvider.notifier);
            notifier.toggleExpansion([
              Factions.marquiseDeCat,
              Factions.eerieDynasty,
              Factions.woodlandAlliance,
              Factions.vagabond
            ]);
          },
          child: const Text('Base game'),
        ),
        const Expanded(
            child: Row(
          children: [
            FactionFilter(faction: Factions.marquiseDeCat),
            FactionFilter(faction: Factions.eerieDynasty),
            FactionFilter(faction: Factions.woodlandAlliance),
            FactionFilter(faction: Factions.vagabond),
          ],
        )),
      ],
    ));
  }
}
