import 'package:flutter/material.dart';
import 'package:root_randomizer/widgets/expansion_filter.dart';

class FactionsFilter extends StatelessWidget {
  const FactionsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        ExpansionFilter(),
      ],
    ));
  }
}
