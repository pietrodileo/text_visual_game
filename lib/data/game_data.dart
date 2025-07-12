import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/player.dart';
import 'package:flutter/foundation.dart';

class GameData {
  static Map<String, dynamic>? _playerData;
  static Player? _player;

  static Future<void> loadPlayer([String filename = 'arbeid.json']) async {
    try {
      final jsonString = await rootBundle.loadString('assets/players/$filename');
      _playerData = json.decode(jsonString)['player'];
      _player = Player.fromJson(_playerData!);
    } catch (e) {
      debugPrint('Errore caricamento file $filename: $e');
    }
  }

  static Player get player => _player!;

  static num getPlayerStat(String statName) {
    switch (statName.toLowerCase()) {
      case 'strength':
        return _player?.strength ?? 0;
      case 'agility':
        return _player?.agility ?? 0;
      case 'constitution':
        return _player?.constitution ?? 0;
      case 'wisdom':
        return _player?.wisdom ?? 0;
      case 'charisma':
        return _player?.charisma ?? 0;
      case 'health':
        return _player?.health ?? 0;
      case 'mana':
        return _player?.mana ?? 0;
      case 'level':
        return _player?.level ?? 0;
      case 'stamina':
        return _player?.stamina ?? 0;
      default:
        return 0;
    }
  }

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
        case 'agility':
          _player!.agility += value;
          break;
        case 'constitution':
          _player!.constitution += value;
          break;
        case 'wisdom':
          _player!.wisdom += value;
          break;
        case 'charisma':
          _player!.charisma += value;
          break;
        case 'stamina':
          _player!.stamina = (_player!.stamina + value).clamp(0.0, 1.0);
          break;
        default:
          break;
      }
    });
  }
}
