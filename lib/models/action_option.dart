// lib/models/action_option.dart
class ActionOption {
  final String label;
  final Check? check;
  final Effect? effects;
  final Effect? effectsSuccess;
  final Effect? effectsFailure;

  ActionOption({
    required this.label,
    this.check,
    this.effects,
    this.effectsSuccess,
    this.effectsFailure,
  });

  factory ActionOption.fromJson(Map<String, dynamic> json) {
    return ActionOption(
      label: json['label'],
      check: json['check'] != null ? Check.fromJson(json['check']) : null,
      effects: json['effects'] != null ? Effect.fromJson(json['effects']) : null,
      effectsSuccess: json['effectsSuccess'] != null ? Effect.fromJson(json['effectsSuccess']) : null,
      effectsFailure: json['effectsFailure'] != null ? Effect.fromJson(json['effectsFailure']) : null,
    );
  }
}

class Check {
  final String type;
  final int dc;

  Check({required this.type, required this.dc});

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(type: json['type'], dc: json['dc']);
  }
}

class Effect {
  final String? nextScene;
  final Map<String, dynamic>? player;

  Effect({this.nextScene, this.player});

  factory Effect.fromJson(Map<String, dynamic> json) {
    return Effect(
      nextScene: json['nextScene'],
      player: json['player'],
    );
  }
}
