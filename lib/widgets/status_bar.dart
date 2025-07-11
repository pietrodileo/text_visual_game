import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final double value;
  final Color color;

  const StatusBar({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
