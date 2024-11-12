import 'package:flutter/material.dart';

class RandomizerResult extends StatelessWidget {
  const RandomizerResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
      ],
    ));
  }
}
