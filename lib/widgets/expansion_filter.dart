import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/faction_icon_status.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';
import 'package:root_randomizer/widgets/faction_filter.dart';

enum ExpansionStatus {
  full(
      widget: Icon(
    Icons.check_box,
    color: Colors.green,
  )),
  none(
      widget: Icon(
    Icons.disabled_by_default_rounded,
    color: Colors.red,
  )),
  some(
      widget: Icon(
    Icons.question_mark_rounded,
    color: Colors.blue,
  ));

  const ExpansionStatus({required this.widget});

  final Widget widget;
}

class ExpansionFilter extends ConsumerWidget {
  const ExpansionFilter(
      {super.key, required this.expansionName, required this.factions});

  final String expansionName;
  final List<Factions> factions;

  ExpansionStatus getExpansionStatus(FactionsFilter factionsFilter) {
    final isAllForbidden = factions.every((faction) =>
        factionsFilter.getStatus(faction) == FactionIconStatus.forbidden);
    if (isAllForbidden) {
      return ExpansionStatus.none;
    }
    final isAnyForbidden = factions.any((faction) =>
        factionsFilter.getStatus(faction) == FactionIconStatus.forbidden);
    if (isAnyForbidden) {
      return ExpansionStatus.some;
    }
    return ExpansionStatus.full;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factionFilterWidgets = factions
        .map(
          (faction) => FactionFilter(faction: faction),
        )
        .toList();
    final factionsFilter = ref.watch(factionsFilterProvider);
    final expansionStatus = getExpansionStatus(factionsFilter);

    return Column(
      children: [
        TextButton(
            onPressed: () {
              final notifier = ref.read(factionsFilterProvider.notifier);
              notifier.toggleExpansion(factions);
            },
            child: Row(
              children: [
                expansionStatus.widget,
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(expansionName,
                  style: const TextStyle(color: Colors.black)),
                ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: factionFilterWidgets,
        ),
      ],
    );
  }
}
