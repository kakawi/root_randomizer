import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root_randomizer/repository/providers/balance_provider.dart';

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        BalanceButton(targetBalance: Balance.balanced),
        BalanceButton(targetBalance: Balance.chaotic),
        BalanceButton(targetBalance: Balance.anarchic),
      ],
    );
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
