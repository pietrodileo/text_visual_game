import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game/scene_manager.dart';
import '../widgets/background.dart';
import '../widgets/top_bar.dart';
import '../widgets/dice_roller.dart';
import '../data/game_data.dart';

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

              const SizedBox(height: 20),

              DiceRoller(),

              const SizedBox(height: 20),

              // Pulsanti per azioni
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: currentScene.actions.map((action) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (action.check != null) {
                          // gestione prova D20 da implementare qui
                        }

                        // Applica gli effetti senza check
                        if (action.effects != null) {
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
