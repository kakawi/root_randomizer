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
    if (forbiddenFactions.contains(faction)) {
      newForbiddenFactions.remove(faction);
    }
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: newMandatoryFactions);
  }

  FactionsFilter toggleFaction(Factions faction) {
    final newForbiddenFactions = {...forbiddenFactions};
    final newMandatoryFactions = {...mandatoryFactions};
    if (forbiddenFactions.contains(faction)) {
      newForbiddenFactions.remove(faction);
      return FactionsFilter(
          forbiddenFactions: newForbiddenFactions,
          mandatoryFactions: newMandatoryFactions);
    }

    if (mandatoryFactions.contains(faction)) {
      newMandatoryFactions.remove(faction);
      return FactionsFilter(
          forbiddenFactions: newForbiddenFactions,
          mandatoryFactions: newMandatoryFactions);
    }

    newForbiddenFactions.add(faction);
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: newMandatoryFactions);
  }

  List<Factions> getAvailableFactions({int? limit}) {
    final result = Factions.values.toSet();
    result.removeAll(forbiddenFactions);
    result.removeAll(mandatoryFactions);
    if (limit == null) {
      return result.toList();
    }
    final shuffledResult = result.toList();
    shuffledResult.shuffle();
    return shuffledResult.take(limit).toList();
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
