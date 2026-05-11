import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberOfPlayersNotifier extends Notifier<int> {
  @override
  int build() => 4;

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
    NotifierProvider<NumberOfPlayersNotifier, int>(
  NumberOfPlayersNotifier.new,
);
