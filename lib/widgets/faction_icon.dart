import 'package:flutter/material.dart';
import 'package:root_randomizer/repository/providers/factions_filter_provider.dart';

class FactionIcon extends StatelessWidget {
  final Factions faction;

  const FactionIcon({super.key, required this.faction});

  String getFactionAssetImage(Factions faction) {
    switch (faction) {
      case Factions.marquiseDeCat:
        return 'assets/images/marquise_de_cat.png';
      case Factions.eyrieDynasty:
        return 'assets/images/eyrie_dynasty.png';
      case Factions.woodlandAlliance:
        return 'assets/images/woodland_alliance.png';
      case Factions.vagabond:
        return 'assets/images/vagabond.png';

      case Factions.lizardCult:
        return 'assets/images/lizard_cult.png';
      case Factions.riverfolkCompany:
        return 'assets/images/riverfolk_company.png';
      case Factions.secondVagabond:
        return 'assets/images/second_vagabond.png';

      case Factions.corvidConspiracy:
        return 'assets/images/corvid_conspiracy.png';
      case Factions.undergroundDuchy:
        return 'assets/images/underground_duchy.png';

      case Factions.lordOfTheHundreds:
        return 'assets/images/lord_of_the_hundreds.png';
      case Factions.keepersInIron:
        return 'assets/images/keepers_in_iron.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(getFactionAssetImage(faction)),
          Text(
            'Reach: ${faction.reach.toString()}',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 400 ? 8 : 10,
            ),
          )
        ]);
  }
}
