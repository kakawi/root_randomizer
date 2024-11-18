import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/balance_provider.dart';
import 'package:root_randomizer/repository/providers/randomization_provider.dart';

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final totalReach = ref.watch(randomizerResultProvider).totalReach;
    final isSatisfiedBalance = this.isSatisfiedBalance(balance, totalReach);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(
        children: [
          BalanceButton(targetBalance: Balance.balanced),
          BalanceButton(targetBalance: Balance.chaotic),
          BalanceButton(targetBalance: Balance.anarchic),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Current Reach: $totalReach',
            style: TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: isSatisfiedBalance ? Colors.black : Colors.red,
            ),
          ),
          Text(
            generateBalanceRuleText(balance),
            style: const TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      )
    ]);
  }

  String generateBalanceRuleText(Balance balance) {
    switch (balance) {
      case Balance.balanced:
        return 'Goal Reach: ≥';
      case Balance.chaotic:
        return 'Goal Reach: ≥17';
      case Balance.anarchic:
        return 'No limits';
    }
  }

  bool isSatisfiedBalance(Balance balance, int totalReach) {
    switch (balance) {
      case Balance.balanced:
        return totalReach >= 12;
      case Balance.chaotic:
        return totalReach >= 17;
      case Balance.anarchic:
        return true;
    }
  }
}

class BalanceButton extends ConsumerWidget {
  const BalanceButton({super.key, required this.targetBalance});

  final Balance targetBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBalance = ref.watch(balanceProvider);
    final isSelected = currentBalance == targetBalance;

    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: isSelected
              ? MaterialStateProperty.all(Colors.green)
              : MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          ref.read(balanceProvider.notifier).changeBalance(targetBalance);
        },
        child: Text(capitalize(targetBalance.name)),
      ),
    );
  }
}

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
