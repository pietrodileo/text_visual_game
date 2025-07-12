import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/game_data.dart';
import '../models/action_option.dart';

class DiceCheckDialog extends StatefulWidget {
  final Check check;

  const DiceCheckDialog({super.key, required this.check});

  @override
  State<DiceCheckDialog> createState() => _DiceCheckDialogState();
}

class _DiceCheckDialogState extends State<DiceCheckDialog> {
  final Random random = Random();
  int currentRoll = 1;
  bool rolling = true;
  String resultText = '';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startRoll();
  }

  void _startRoll() {
    int rollCount = 0;
    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      setState(() {
        currentRoll = random.nextInt(20) + 1;
      });
      rollCount++;
      if (rollCount >= 20) {
        t.cancel();
        _finalizeResult();
      }
    });
  }

  void _finalizeResult() {
    final stat = widget.check.type;
    final dc = widget.check.dc;
    final statMod = GameData.getPlayerStat(stat);
    final total = currentRoll + statMod;
    final success = total >= dc;

    setState(() {
      rolling = false;
      resultText = '''
      Tiro: $currentRoll
      ${stat[0].toUpperCase()}${stat.substring(1)}: +$statMod
      Totale: $total vs CD $dc

      ${success ? "✔ Successo!" : "✘ Fallimento"}
      ''';
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Prova abilità"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rolling)
            Text('Tiro del dado...\n$currentRoll',
                style: const TextStyle(fontSize: 24))
          else
            Text(resultText, style: const TextStyle(fontSize: 18)),
        ],
      ),
      actions: [
        if (!rolling)
          TextButton(
            onPressed: () => Navigator.pop(context, currentRoll),
            child: const Text("OK"),
          )
      ],
    );
  }
}
