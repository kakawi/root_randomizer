import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

class PlayersWidget extends ConsumerWidget {
  const PlayersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfPlayers = ref.watch(numberOfPlayersProvider);
    final notifier = ref.read(numberOfPlayersProvider.notifier);
    return Expanded(
        child: Row(
      children: [
        const Text("Number of players: "),
        ElevatedButton(onPressed: notifier.decrement, child: const Text("-1")),
        Text(numberOfPlayers.toString()),
        ElevatedButton(onPressed: notifier.increment, child: const Text("+1")),
      ],
    ));
  }
}
