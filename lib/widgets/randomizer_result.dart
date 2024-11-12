import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/repository/providers/randomization_provider.dart';
import 'package:root_randomizer/widgets/faction_icon.dart';

String ordinal(int number) {
  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

class RandomizerResult extends ConsumerWidget {
  const RandomizerResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomizerResult = ref.watch(randomizerResultProvider);
    if (randomizerResult.status == ResultStatus.error) {
      return Text(randomizerResult.errorMessage!);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Game setup: ",),
        for (final (int index, Factions faction)
            in randomizerResult.factions.indexed)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ordinal(index + 1)),
              FactionIcon(
                faction: faction,
              ),
            ],
          ),
        IconButton(
            onPressed: ref.read(randomizerResultProvider.notifier).randomize,
            icon: const Icon(Icons.restart_alt_rounded))
      ],
    );
  }
}
