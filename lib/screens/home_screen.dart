import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  ///
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween(end: 1.0, begin: 0.0).animate(animationController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) => animationStatus = status);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(pi * -1 * animation.value),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Card(
                    child: animation.value <= 0.5
                        ? Container(
                            color: Colors.blueAccent,
                            width: 240,
                            height: 300,
                            child: const Center(
                              child: Text(
                                '?',
                                style: TextStyle(
                                    fontSize: 100, color: Colors.white),
                              ),
                            ),
                          )
                        : Container(
                            width: 240,
                            height: 300,
                            color: Colors.grey,
                            child: Image.network(
                              'https://www.dbestech.com/img/mobile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (animationStatus == AnimationStatus.dismissed) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
              },
              child: const Text('reverse'),
            ),
          ],
        ),
      ),
    );
  }
}
