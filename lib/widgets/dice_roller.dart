import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  final Random random = Random();
  int currentRoll = 1;
  bool rolling = false;

  void rollDice() {
    if (rolling) return; // blocca se già in animazione

    rolling = true;
    int rollCount = 0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentRoll = random.nextInt(20) + 1;
      });

      rollCount++;
      if (rollCount >= 20) { // circa 2 secondi di animazione
        timer.cancel();
        rolling = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Lancio D20: $currentRoll',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: rollDice,
          child: const Text('Lancia dado'),
        ),
      ],
    );
  }
}
