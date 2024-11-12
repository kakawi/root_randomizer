import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/faction_icon_status.dart';

enum Factions {
  marquiseDeCat,
  eerieDynasty,
  woodlandAlliance,
  vagabond,
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
          mandatoryFactions: mandatoryFactions);
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

  void addMandatoryFaction(Factions faction) {
    state = state.addMandatory(faction);
  }
}

final factionsFilterProvider =
    StateNotifierProvider<FactionsFilterNotifier, FactionsFilter>(
  (ref) => FactionsFilterNotifier(),
);
