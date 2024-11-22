import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/faction_icon_status.dart';

enum Factions {
  marquiseDeCat(reach: 10),
  eyrieDynasty(reach: 7),
  woodlandAlliance(reach: 3),
  vagabond(reach: 5),

  // The Riverfolk Expansion
  lizardCult(reach: 2),
  riverfolkCompany(reach: 5),
  secondVagabond(reach: 2),

  // The Underworld Expansion
  corvidConspiracy(reach: 3),
  undergroundDuchy(reach: 8),

  // The Marauder Expansion
  lordOfTheHundreds(reach: 9),
  keepersInIron(reach: 8);

  // Homeland Expansion

  const Factions({required this.reach});

  final int reach;
}

class FactionsFilter {
  const FactionsFilter(
      {required this.forbiddenFactions, required this.mandatoryFactions});

  final Set<Factions> forbiddenFactions;
  final Set<Factions> mandatoryFactions;

  FactionIconStatus getStatus(Factions faction) {
    if (mandatoryFactions.contains(faction)) {
      return FactionIconStatus.mandatory;
    } else if (forbiddenFactions.contains(faction)) {
      return FactionIconStatus.forbidden;
    } else {
      return FactionIconStatus.neutral;
    }
  }

  FactionsFilter addMandatory(Factions faction) {
    final newForbiddenFactions = {...forbiddenFactions};
    final newMandatoryFactions = {...mandatoryFactions};
    newMandatoryFactions.add(faction);
    newForbiddenFactions.remove(faction);

    // if secondVagabond mandatory, then first one too
    if (faction == Factions.secondVagabond) {
      newMandatoryFactions.add(Factions.vagabond);
      newForbiddenFactions.remove(Factions.vagabond);
    }

    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: newMandatoryFactions);
  }

  FactionsFilter toggleFaction(Factions faction) {
    final newForbiddenFactions = {...forbiddenFactions};
    final newMandatoryFactions = {...mandatoryFactions};
    // forbidden -> available
    if (forbiddenFactions.contains(faction)) {
      newForbiddenFactions.remove(faction);
      // If Second Vagabond is available, then Vagabond is also available
      if (isSecondVagabond(faction)) {
        newForbiddenFactions.remove(Factions.vagabond);
      }
      return FactionsFilter(
          forbiddenFactions: newForbiddenFactions,
          mandatoryFactions: newMandatoryFactions);
    }

    // mandatory -> available
    if (mandatoryFactions.contains(faction)) {
      newMandatoryFactions.remove(faction);
      // If Vagabond is available, then Second Vagabond is not mandatory
      if (isFirstVagabond(faction)) {
        newMandatoryFactions.remove(Factions.secondVagabond);
      }
      return FactionsFilter(
          forbiddenFactions: newForbiddenFactions,
          mandatoryFactions: newMandatoryFactions);
    }

    // available -> forbidden
    newForbiddenFactions.add(faction);
    // If Vagabond is forbidden, then Second Vagabond is also forbidden
    if (isFirstVagabond(faction)) {
      newMandatoryFactions.remove(Factions.secondVagabond);
      newForbiddenFactions.add(Factions.secondVagabond);
    }
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: newMandatoryFactions);
  }

  List<Factions> getAvailableFactions() {
    final result = Factions.values.toSet();
    result.removeAll(forbiddenFactions);
    result.removeAll(mandatoryFactions);
    return result.toList();
  }

  FactionsFilter addForbiddenFactions(Iterable<Factions> factions) {
    final newForbiddenFactions = {...forbiddenFactions};
    final newMandatoryFactions = {...mandatoryFactions};
    newForbiddenFactions.addAll(factions);
    newMandatoryFactions.removeAll(factions);
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: newMandatoryFactions);
  }

  FactionsFilter removeForbiddenFactions(Iterable<Factions> factions) {
    final newForbiddenFactions = {...forbiddenFactions};
    newForbiddenFactions.removeAll(factions);
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: mandatoryFactions);
  }

  List<List<Factions>> findPossibleCombinations(
      {required int limit, required int targetReach}) {
    final availableFactions = getAvailableFactions();
    List<List<Factions>> possibleCombinations = [];

    void findPath(List<Factions> restFactions, int restLimit, int restReach,
        List<Factions> currentPath, List<List<Factions>> result) {
      if (restLimit == 0) {
        if (restReach <= 0) {
          result.add(currentPath);
        }
        return;
      }
      for (Factions faction in restFactions) {
        List<Factions> newRestFactions = List.from(restFactions)
          ..remove(faction);
        List<Factions> newCurrentPath = List.from(currentPath)..add(faction);
        findPath(newRestFactions, restLimit - 1, restReach - faction.reach,
            newCurrentPath, result);
      }
    }

    findPath(availableFactions, limit, targetReach, [], possibleCombinations);
    possibleCombinations.shuffle();
    return possibleCombinations;
  }

  bool isFirstVagabond(Factions faction) {
    return faction == Factions.vagabond;
  }

  bool isSecondVagabond(Factions faction) {
    return faction == Factions.secondVagabond;
  }
}

class FactionsFilterNotifier extends StateNotifier<FactionsFilter> {
  FactionsFilterNotifier()
      : super(const FactionsFilter(
          forbiddenFactions: {},
          mandatoryFactions: {},
        ));

  void toggleFaction(Factions faction) {
    state = state.toggleFaction(faction);
  }

  void toggleExpansion(Iterable<Factions> factions) {
    final bool isAnyAllowed =
        factions.any((faction) => !state.forbiddenFactions.contains(faction));
    if (isAnyAllowed) {
      state = state.addForbiddenFactions(factions);
    } else {
      state = state.removeForbiddenFactions(factions);
    }
  }

  void addMandatoryFaction(Factions faction) {
    state = state.addMandatory(faction);
  }
}

final factionsFilterProvider =
    StateNotifierProvider<FactionsFilterNotifier, FactionsFilter>(
  (ref) => FactionsFilterNotifier(),
);
