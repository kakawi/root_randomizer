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

class RandomizerResultWidget extends ConsumerWidget {
  const RandomizerResultWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWidget = getShowWidget(ref);
    return Container(
      constraints: const BoxConstraints(
        minHeight: 75,
      ),
      child: showWidget,
    );
  }

  getShowWidget(WidgetRef ref) {
    final randomizerResult = ref.watch(randomizerResultProvider);
    if (randomizerResult.status == ResultStatus.error) {
      return Center(child: Text(randomizerResult.errorMessage!));
    }

    var grid = generateGrid(randomizerResult);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Setup: ",
        ),
        Expanded(
            child: Column(
          children: grid,
        )),
        IconButton(
            onPressed: ref.read(randomizerResultProvider.notifier).randomize,
            icon: const Icon(Icons.restart_alt_rounded))
      ],
    );
  }

  List<Widget> generateGrid(RandomizerResult randomizerResult) {
    var resultFactions = randomizerResult.factions;
    if (resultFactions.length > 4) {
      return [
        generateRow(factions: resultFactions.sublist(0, 4)),
        generateRow(factions: resultFactions.sublist(4), prefix: 4)
      ];
    } else {
      return [generateRow(factions: resultFactions)];
    }
  }

  Row generateRow({required List<Factions> factions, int prefix = 0}) {
    final isSecondRow = prefix > 0;
    int spacers = 4 - factions.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final (int index, Factions faction) in factions.indexed)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ordinal(prefix + index + 1)),
                FactionIcon(
                  faction: faction,
                ),
              ],
            ),
          ),
          for (int i = 0; i < spacers; i++)
            const Spacer(),
      ],
    );
  }
}
