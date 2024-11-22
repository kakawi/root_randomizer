import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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

  SvgPicture getSvgIcon(FactionIconStatus status) {
    final iconPath = getSvgIconPath(status);
    final color = getBorderColor(status);
    return SvgPicture.asset(
      iconPath,
      width: 12,
      height: 12,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  String getSvgIconPath(FactionIconStatus status) {
    switch (status) {
      case FactionIconStatus.forbidden:
        return 'assets/icons/cross.svg';
      case FactionIconStatus.mandatory:
        return 'assets/icons/locked_lock.svg';
      case FactionIconStatus.neutral:
        return 'assets/icons/open_lock.svg';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factionsFilter = ref.watch(factionsFilterProvider);
    final status = factionsFilter.getStatus(faction);
    final borderColor = getBorderColor(status);
    final svgIcon = getSvgIcon(status);

    final notifier = ref.read(factionsFilterProvider.notifier);

    return GestureDetector(
      onTap: () {
        notifier.toggleFaction(faction);
      },
      onLongPress: () {
        notifier.addMandatoryFaction(faction);
      },
      child: Stack(
        children: [
          Container(
            width: 70,
            height: 70,
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
          Positioned(
            top: 4,
            left: 12,
            child: svgIcon,
          ),
        ],
      ),
    );
  }
}
