import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imagePath;

  const Background({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
