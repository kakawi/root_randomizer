import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/repository/providers/randomization_provider.dart';
import 'package:root_randomizer/widgets/faction_icon.dart';

class RandomizerResult extends ConsumerWidget {
  const RandomizerResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomizerResult = ref.watch(randomizerResultProvider);
    if (randomizerResult.status == ResultStatus.error) {
      return Text(randomizerResult.errorMessage!);
    }
    return Expanded(
        child: Row(
      children: [
        for (Factions faction in randomizerResult.factions)
          FactionIcon(
            faction: faction,
          ),
        IconButton(
            onPressed: ref.read(randomizerResultProvider.notifier).randomize,
            icon: const Icon(Icons.restart_alt_rounded))
      ],
    ));
  }
}
