import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game/scene_manager.dart';
import '../widgets/background.dart';
import '../widgets/top_bar.dart';
import '../widgets/dice_roller.dart';
import '../data/game_data.dart';
import '../widgets/dice_check_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sceneManager = context.watch<SceneManager>();
    final currentScene = sceneManager.currentScene;
    final player = GameData.player;

    if (currentScene == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Background(imagePath: currentScene.background),

          Column(
            children: [
              TopBar(player: player),

              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(12),
                  color: Colors.black.withOpacity(0.6),
                  child: SingleChildScrollView(
                    child: Text(
                      currentScene.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              // Pulsanti per azioni
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: currentScene.actions.map((action) {
                    return ElevatedButton(
                    onPressed: () async {
                      debugPrint('Entro qui');
                      if (action.check != null) {
                          // Mostra animazione
                          final roll = await showDialog<int>(
                            context: context,
                            builder: (_) => DiceCheckDialog(check: action.check!),
                          );
                        
                          if (roll == null) return;

                          final stat = action.check!.type;
                          final dc = action.check!.dc;
                          final statValue = GameData.getPlayerStat(stat);
                          final total = roll + statValue;
                          final success = total >= dc;

                          debugPrint('Hai tirato: $roll + ${action.check!.type}($statValue) = $total');
                          debugPrint('CD: ${action.check!.dc}');

                          // Applica gli effetti
                          if (success && action.effectsSuccess != null) {
                            await sceneManager.performAction(action.effectsSuccess!);
                          } else if (!success && action.effectsFailure != null) {
                            await sceneManager.performAction(action.effectsFailure!);
                          }
                      } else if (action.effects != null) {
                        await sceneManager.performAction(action.effects!);
                      }
                    },
                      child: Text(action.label),
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
