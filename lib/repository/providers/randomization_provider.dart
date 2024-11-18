import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/repository/providers/number_of_players_provider.dart';

enum ResultStatus { success, error }

class RandomizerResult {
  final List<Factions> factions;
  final ResultStatus status;
  final String? errorMessage;

  RandomizerResult(
      {required this.factions, required this.status, this.errorMessage});

  int get totalReach {
    return factions.fold(
        0, (previousValue, element) => previousValue + element.reach);
  }
}

class RandomizerResultNotifier extends Notifier<RandomizerResult> {
  @override
  RandomizerResult build() {
    final numberOfPlayers = ref.watch(numberOfPlayersProvider);
    final filter = ref.watch(factionsFilterProvider);

    final mandatoryFactionsNumber = filter.mandatoryFactions.length;
    final neededMoreFactions = numberOfPlayers - mandatoryFactionsNumber;
    // 1. Too many mandatory factions
    if (neededMoreFactions < 0) {
      return RandomizerResult(
        factions: filter.mandatoryFactions.toList(),
        status: ResultStatus.error,
        errorMessage: 'Too many mandatory factions',
      );
    }

    // 2. Not enough available factions
    if (filter.getAvailableFactions().length < neededMoreFactions) {
      List<Factions> possibleFactions = [];
      possibleFactions.addAll(filter.mandatoryFactions);
      possibleFactions.addAll(filter.getAvailableFactions());
      return RandomizerResult(
        factions: possibleFactions,
        status: ResultStatus.error,
        errorMessage: 'Not enough available factions',
      );
    }

    // 3. Success
    final mandatoryFactions = filter.mandatoryFactions;
    final randomAvailableFactions =
        filter.getAvailableFactions(limit: neededMoreFactions);
    final resultFactions = [...mandatoryFactions, ...randomAvailableFactions];
    resultFactions.shuffle();

    return RandomizerResult(
      factions: resultFactions,
      status: ResultStatus.success,
    );
  }

  void randomize() {
    state = build();
  }
}

final randomizerResultProvider =
    NotifierProvider<RandomizerResultNotifier, RandomizerResult>(
        RandomizerResultNotifier.new);
