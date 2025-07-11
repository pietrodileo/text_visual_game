import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/player.dart';
import 'package:flutter/foundation.dart';

class GameData {
  static Map<String, dynamic>? _playerData;
  static Player? _player;

  static Future<void> loadPlayer([String filename = 'pedrestar.json']) async {
    try {
      final jsonString = await rootBundle.loadString('/players/$filename');
      _playerData = json.decode(jsonString)['player'];
      _player = Player.fromJson(_playerData!);
    } catch (e) {
      debugPrint('Errore caricamento file $filename: $e');
    }
  }

  static Player get player => _player!;

  static void updatePlayerStats(Map<String, dynamic> updates) {
    updates.forEach((key, value) {
      switch (key) {
        case 'health':
          _player!.health = (_player!.health + value).clamp(0.0, 1.0);
          break;
        case 'mana':
          _player!.mana = (_player!.mana + value).clamp(0.0, 1.0);
          break;
        case 'level':
          _player!.level += value;
          break;
        case 'strength':
          _player!.strength += value;
          break;
        // aggiungi altri campi se vuoi
      }
    });
  }
}
