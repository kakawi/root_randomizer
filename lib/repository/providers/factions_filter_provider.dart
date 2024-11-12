import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/faction_icon_status.dart';

enum Factions {
  marquiseDeCat,
  eyrieDynasty,
  woodlandAlliance,
  vagabond,

  // The Riverfolk Expansion
  lizardCult,
  riverfolkCompany,
  secondVagabond,

  // The Underworld Expansion
  corvidConspiracy,
  undergroundDuchy,

  // The Marauder Expansion
  lordOfTheHundreds,
  keepersInIron,

  // Homeland Expansion
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
    newForbiddenFactions.addAll(factions);
    mandatoryFactions.removeAll(factions);
    return FactionsFilter(
        forbiddenFactions: newForbiddenFactions,
        mandatoryFactions: mandatoryFactions);
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
