import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Funzionalità logica del dado D20
class DiceRoller {
  static final _random = Random();

  /// Tiro rapido per logica di gioco (es: prove abilità)
  static int rollD20() => _random.nextInt(20) + 1;
}

/// Widget animato per mostrare il tiro a schermo
class DiceRollerWidget extends StatefulWidget {
  const DiceRollerWidget({super.key});

  @override
  State<DiceRollerWidget> createState() => _DiceRollerWidgetState();
}

class _DiceRollerWidgetState extends State<DiceRollerWidget> {
  final Random random = Random();
  int currentRoll = 1;
  bool rolling = false;

  void rollDice() {
    if (rolling) return;

    rolling = true;
    int rollCount = 0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentRoll = random.nextInt(20) + 1;
      });

      rollCount++;
      if (rollCount >= 20) {
        timer.cancel();
        rolling = false;
        // potresti chiamare un callback qui se serve
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
