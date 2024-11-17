import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Balance {
  balanced,
  chaotic,
  anarchic,
}

class BalanceNotifier extends StateNotifier<Balance> {
  BalanceNotifier() : super(Balance.balanced);

  void changeBalance(Balance newBalance) {
    state = newBalance;
  }
}

final balanceProvider = StateNotifierProvider<BalanceNotifier, Balance>(
  (ref) => BalanceNotifier(),
);
