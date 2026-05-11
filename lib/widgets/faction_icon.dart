import 'package:flutter/material.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';

class FactionIcon extends StatelessWidget {
  final Factions faction;
  final bool isSmall;

  const FactionIcon({super.key, required this.faction, this.isSmall = true});

  String getFactionAssetImage(Factions faction) {
    switch (faction) {
      case Factions.marquiseDeCat:
        return 'assets/images/marquise_de_cat.webp';
      case Factions.eyrieDynasty:
        return 'assets/images/eyrie_dynasty.webp';
      case Factions.woodlandAlliance:
        return 'assets/images/woodland_alliance.webp';
      case Factions.vagabond:
        return 'assets/images/vagabond.webp';

      case Factions.lizardCult:
        return 'assets/images/lizard_cult.webp';
      case Factions.riverfolkCompany:
        return 'assets/images/riverfolk_company.webp';
      case Factions.secondVagabond:
        return 'assets/images/vagabond.webp';

      case Factions.corvidConspiracy:
        return 'assets/images/corvid_conspiracy.webp';
      case Factions.undergroundDuchy:
        return 'assets/images/underground_duchy.webp';

      case Factions.lordOfTheHundreds:
        return 'assets/images/lord_of_the_hundreds.webp';
      case Factions.keepersInIron:
        return 'assets/images/keepers_in_iron.webp';

      case Factions.knavesOfTheDeepwood:
        return 'assets/images/knaves_of_the_deepwood.webp';
      case Factions.lilypadDiaspora:
        return 'assets/images/lilypad_diaspora.webp';
      case Factions.twilightCouncil:
        return 'assets/images/twilight_council.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double? size = isSmall ? 32 : null;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(getFactionAssetImage(faction), width: size, height: size),
          Text(
            'Reach: ${faction.reach.toString()}',
            style: TextStyle(
              fontSize: isSmall ? 8 : 10,
            ),
          )
        ]);
  }
}
