import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberOfPlayersNotifier extends StateNotifier<int> {
  NumberOfPlayersNotifier() : super(4);

  void increment() {
    if (state == 6) {
      return;
    }
    state++;
  }

  void decrement() {
    if (state == 2) {
      return;
    }
    state--;
  }
}

final numberOfPlayersProvider =
    StateNotifierProvider<NumberOfPlayersNotifier, int>(
  (ref) => NumberOfPlayersNotifier(),
);
