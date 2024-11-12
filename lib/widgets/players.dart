import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

class PlayersWidget extends ConsumerWidget {
  const PlayersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfPlayers = ref.watch(numberOfPlayersProvider);
    final notifier = ref.read(numberOfPlayersProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Number of players: "),
        Row(
          children: [
            IconButton(
                onPressed: notifier.decrement,
                icon: const Icon(
                  Icons.exposure_neg_1,
                  color: Colors.blue,
                  size: 32,
                )),
            const SizedBox(width: 10),
            Text(
              numberOfPlayers.toString(),
              style: TextStyle(fontSize: 52),
            ),
            const SizedBox(width: 10),
            IconButton(
                onPressed: notifier.increment,
                icon: const Icon(
                  Icons.exposure_plus_1,
                  color: Colors.blue,
                  size: 32,
                )),
          ],
        )
      ],
    );
  }
}
