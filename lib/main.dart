import 'package:flutter/material.dart';
import 'package:test_flip_card_animation/screens/home_screen.dart';
import 'package:test_flip_card_animation/screens/tarot_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TarotScreen());
  }
}
