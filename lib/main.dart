import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/scene_manager.dart';
import 'data/game_data.dart';
import 'screens/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carica i dati del player prima di avviare l'app
  await GameData.loadPlayer(); // default: pedrestar.json

  runApp(
    ChangeNotifierProvider(
      create: (_) => SceneManager()..start(), // start() carica la scena iniziale
      child: const TextAdventureGame(),
    ),
  );
}

class TextAdventureGame extends StatelessWidget {
  const TextAdventureGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Adventure',
      theme: ThemeData.dark(),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
