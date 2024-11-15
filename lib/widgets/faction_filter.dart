import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/faction_icon_status.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';

import 'package:root_randomizer/widgets/faction_icon.dart';

class FactionFilter extends ConsumerWidget {
  const FactionFilter({super.key, required this.faction});

  final Factions faction;

  getBorderColor(FactionIconStatus status) {
    switch (status) {
      case FactionIconStatus.mandatory:
        return Colors.green;
      case FactionIconStatus.forbidden:
        return Colors.red;
      case FactionIconStatus.neutral:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factionsFilter = ref.watch(factionsFilterProvider);
    final status = factionsFilter.getStatus(faction);
    final borderColor = getBorderColor(status);

    final notifier = ref.read(factionsFilterProvider.notifier);

    return GestureDetector(
      onTap: () {
        notifier.toggleFaction(faction);
      },
      onLongPress: () {
        notifier.addMandatoryFaction(faction);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          shape: BoxShape.rectangle,
        ),
        child: FactionIcon(
          faction: faction,
        ),
      ),
    );
  }
}
