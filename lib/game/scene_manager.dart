import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:text_game/models/action_option.dart';
import '../data/game_data.dart';
import '../models/scene.dart';

class SceneManager extends ChangeNotifier {
  Scene? _currentScene;
  String? _currentSceneId;
  String? _currentChapter;

  // Cache per migliorare performance e non ricaricare più volte
  final Map<String, Scene> _cache = {};

  Scene? get currentScene => _currentScene;
  String? get currentSceneId => _currentSceneId;
  String? get currentChapter => _currentChapter;

  /// Carica la scena identificata da [sceneId]
  Future<void> loadScene(String chapterId, String sceneId) async {
    if (_cache.containsKey(sceneId)) {
      _currentScene = _cache[sceneId];
      _currentSceneId = sceneId;
      _currentChapter = chapterId;
      notifyListeners();
      return;
    }

    try {  
      final jsonString = await rootBundle.loadString('scenes/chapters/$chapterId/$sceneId.json');
      final jsonData = json.decode(jsonString);
      final sceneJson = jsonData['scenes'][sceneId]; // ✅
      final scene = Scene.fromJson(sceneId, sceneJson);

      _cache[sceneId] = scene;
      _currentScene = scene;
      _currentSceneId = sceneId;

      notifyListeners();
    } catch (e) {
      debugPrint('Errore caricamento scena $sceneId, capitolo $chapterId: $e');
      // Puoi decidere di gestire meglio l'errore (es. scena fallback)
    }
  }

  /// Metodo per inizializzare con la scena di partenza
  Future<void> start() async {
    await loadScene('chapter1','start');
  } 

  /// Esempio di metodo per applicare effetti, cambia scena, ecc.
  Future<void> performAction(Effect effects) async {
    if (effects.player != null) {
      GameData.updatePlayerStats(effects.player!);
    }

    if (effects.nextScene != null) {
      await loadScene(effects.nextChapter!,effects.nextScene!);
    } else {
      notifyListeners();
    }
  }

}
