import 'package:flutter/material.dart';

enum Factions {
  marquiseDeCat,
  eerieDynasty,
  woodlandAlliance,
  vagabond,
}

class FactionIcon extends StatelessWidget {
  final Factions faction;

  const FactionIcon({super.key, required this.faction});

  IconData iconForFaction(Factions faction) {
    switch (faction) {
      case Factions.marquiseDeCat:
        return Icons.pets;
      case Factions.eerieDynasty:
        return Icons.bug_report;
      case Factions.woodlandAlliance:
        return Icons.eco;
      case Factions.vagabond:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(iconForFaction(faction));
  }
}
