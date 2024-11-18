import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

enum BalanceMode {
  balanced,
  chaotic,
  anarchic,
}

class CurrentBalance {
  const CurrentBalance({required this.balanceMode, required this.goalReach});

  final BalanceMode balanceMode;
  final int goalReach;
}

class BalanceNotifier extends StateNotifier<CurrentBalance> {
  BalanceNotifier(this.numberOfPlayers)
      : super(CurrentBalance(
            balanceMode: BalanceMode.balanced,
            goalReach:
                calculateGoalReach(BalanceMode.balanced, numberOfPlayers)));

  final int numberOfPlayers;

  void changeBalance(BalanceMode newBalanceMode) {
    if (state.balanceMode == newBalanceMode) return;
    final newGoalReach = calculateGoalReach(newBalanceMode, numberOfPlayers);
    state =
        CurrentBalance(balanceMode: newBalanceMode, goalReach: newGoalReach);
  }
}

final balanceProvider = StateNotifierProvider<BalanceNotifier, CurrentBalance>(
  (ref) => BalanceNotifier(ref.watch(numberOfPlayersProvider)),
);

int calculateGoalReach(BalanceMode balanceMode, int numberOfPlayers) {
  switch (balanceMode) {
    case BalanceMode.balanced:
      switch (numberOfPlayers) {
        case 2:
          return 17;
        case 3:
          return 18;
        case 4:
          return 21;
        case 5:
          return 25;
        case 6:
          return 28;
        default:
          throw Exception('Invalid number of players');
      }
    case BalanceMode.chaotic:
      return 17;
    case BalanceMode.anarchic:
      return 0;
  }
}
