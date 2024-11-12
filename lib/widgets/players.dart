import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersWidget extends ConsumerWidget {
  const PlayersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: Row(
      children: [
        Text("Players: "),
        ElevatedButton(onPressed: () {}, child: Text("-1")),
        Text("5"),
        ElevatedButton(onPressed: () {}, child: Text("+1")),
      ],
    ));
  }
}
