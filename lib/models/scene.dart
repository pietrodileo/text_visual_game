// lib/models/scene.dart
import 'action_option.dart';

class Scene {
  final String id;
  final String text;
  final String background;
  final List<ActionOption> actions;

  Scene({
    required this.id,
    required this.text,
    required this.background,
    required this.actions,
  });

  factory Scene.fromJson(String id, Map<String, dynamic> json) {
    return Scene(
      id: id,
      text: json['text'],
      background: json['background'],
      actions: (json['actions'] as List)
          .map((a) => ActionOption.fromJson(a))
          .toList(),
    );
  }
}
