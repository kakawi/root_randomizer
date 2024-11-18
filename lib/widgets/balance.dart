import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/balance_provider.dart';
import 'package:root_randomizer/repository/providers/randomization_provider.dart';

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBalance = ref.watch(balanceProvider);
    final totalReach = ref.watch(randomizerResultProvider).totalReach;
    final isSatisfiedBalance =
        this.isSatisfiedBalance(currentBalance, totalReach);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(
        children: [
          BalanceButton(targetBalance: BalanceMode.balanced),
          BalanceButton(targetBalance: BalanceMode.chaotic),
          BalanceButton(targetBalance: BalanceMode.anarchic),
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
            generateBalanceRuleText(currentBalance),
            style: const TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      )
    ]);
  }

  String generateBalanceRuleText(CurrentBalance currentBalance) {
    switch (currentBalance.balanceMode) {
      case BalanceMode.anarchic:
        return 'No limits';
      default:
        return 'Goal Reach: ≥${currentBalance.goalReach}';
    }
  }

  bool isSatisfiedBalance(CurrentBalance balance, int totalReach) {
    return totalReach >= balance.goalReach;
  }
}

class BalanceButton extends ConsumerWidget {
  const BalanceButton({super.key, required this.targetBalance});

  final BalanceMode targetBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBalance = ref.watch(balanceProvider);
    final isSelected = currentBalance.balanceMode == targetBalance;

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
