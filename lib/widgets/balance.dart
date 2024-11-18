import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/balance_provider.dart';
import 'package:root_randomizer/repository/providers/randomization_provider.dart';

const verticalDivider =
    VerticalDivider(color: Colors.black, thickness: 1, width: 1);

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBalance = ref.watch(balanceProvider);
    final totalReach = ref.watch(randomizerResultProvider).totalReach;
    final isSatisfiedBalance =
        this.isSatisfiedBalance(currentBalance, totalReach);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const IntrinsicHeight(
        // So VerticalDivider has height to be shown
        child: Row(
          children: [
            BalanceButton(targetBalance: BalanceMode.balanced),
            verticalDivider,
            BalanceButton(targetBalance: BalanceMode.chaotic),
            verticalDivider,
            BalanceButton(targetBalance: BalanceMode.anarchic),
          ],
        ),
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
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          minimumSize: WidgetStateProperty.all(const Size(0, 48)),
          foregroundColor: WidgetStateProperty.all(isSelected
              ? const Color.fromARGB(255, 235, 229, 229)
              : Colors.black),
          backgroundColor: isSelected
              ? WidgetStateProperty.all(const Color.fromARGB(255, 76, 66, 22))
              : WidgetStateProperty.all(const Color.fromARGB(48, 241, 194, 7)),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          )),
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
