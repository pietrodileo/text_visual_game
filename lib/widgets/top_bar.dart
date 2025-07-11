import 'package:flutter/material.dart';
import '../models/player.dart';
import 'status_bar.dart';

class TopBar extends StatelessWidget {
  final Player player;

  const TopBar({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(player.avatarPath),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Livello ${player.level}'),
              Row(
                children: [
                  const Text('❤️'),
                  const SizedBox(width: 4),
                  StatusBar(color: Colors.red, value: player.health),
                  const SizedBox(width: 8),
                  const Text('🔮'),
                  const SizedBox(width: 4),
                  StatusBar(color: Colors.blue, value: player.mana),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
