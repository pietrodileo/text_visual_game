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
                  // Risorse base con barre
                  Row(
                    children: [
                      const Text('❤️'),
                      const SizedBox(width: 4),
                      StatusBar(color: Colors.red, value: player.health),
                      const SizedBox(width: 8),
                      const Text('🔮'),
                      const SizedBox(width: 4),
                      StatusBar(color: Colors.blue, value: player.mana),
                      const SizedBox(width: 8),
                      const Text('⚡'),
                      const SizedBox(width: 4),
                      StatusBar(color: Colors.green, value: player.stamina),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Statistiche base in riga compatta
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildStatBox("🧠 Saggezza", player.wisdom),
                      _buildStatBox("💪 Forza", player.strength),
                      _buildStatBox("🛡️ Costit.", player.constitution),
                      _buildStatBox("🎭 Carisma", player.charisma),
                      _buildStatBox("🏃 Agilità", player.agility),
                      _buildStatBox("⭐ Livello", player.level),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, num value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

}
