import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

final playersButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    minimumSize: Size.zero,
    backgroundColor: const Color.fromARGB(48, 241, 194, 7));

class PlayersWidget extends ConsumerWidget {
  const PlayersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfPlayers = ref.watch(numberOfPlayersProvider);
    final notifier = ref.read(numberOfPlayersProvider.notifier);
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom > 0 
            ? MediaQuery.of(context).padding.bottom + 8 
            : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "Number of players: ",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 400 ? 14 : 16,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: notifier.decrement,
                style: playersButtonStyle.copyWith(
                  minimumSize: WidgetStateProperty.all(Size(
                    MediaQuery.of(context).size.width < 400 ? 35 : 40,
                    MediaQuery.of(context).size.width < 400 ? 35 : 40,
                  )),
                ),
                child: Text(
                  "-",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 20 : 26,
                    color: Colors.black,
                  ),
                )),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width < 400 ? 3 : 5,
                ),
                child: Text(
                  numberOfPlayers.toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 28 : 38,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: notifier.increment,
                style: playersButtonStyle.copyWith(
                  minimumSize: WidgetStateProperty.all(Size(
                    MediaQuery.of(context).size.width < 400 ? 35 : 40,
                    MediaQuery.of(context).size.width < 400 ? 35 : 40,
                  )),
                ),
                child: Text(
                  "+",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 20 : 26,
                    color: Colors.black,
                  ),
                )),
            ],
          ),
        ],
      ),
    );
  }
}