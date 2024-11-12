import 'package:flutter/material.dart';

import 'package:root_randomizer/widgets/faction_icon.dart';

class FactionFilter extends StatelessWidget {
  const FactionFilter(
      {super.key,
      required this.factionIcon,
      required this.onTap,
      required this.onLongPressed});

  final FactionIcon factionIcon;
  final void Function() onTap;
  final void Function() onLongPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPressed,
      onTap: onTap,
      child: factionIcon,
    );
  }
}
