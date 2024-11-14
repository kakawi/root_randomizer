import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

final playersButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    backgroundColor: const Color.fromARGB(48, 241, 194, 7));

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
            ElevatedButton(
                onPressed: notifier.decrement,
                style: playersButtonStyle,
                child: const Text(
                  "-",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                numberOfPlayers.toString(),
                style: const TextStyle(fontSize: 38),
              ),
            ),
            ElevatedButton(
                onPressed: notifier.increment,
                style: playersButtonStyle,
                child: const Text(
                  "+",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                )),
          ],
        )
      ],
    );
  }
}
