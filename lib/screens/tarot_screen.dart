/*
Flutter 3D Flip Card Animation | Tween Rotate
https://www.youtube.com/watch?v=gJEURBqw0PE

【Flutter】画像を裏返して別の画像を表示するアニメーションを実装する
https://techgamelife.net/2021/05/22/flutter-flip-card/#google_vignette
*/

import 'dart:math';

import 'package:flutter/material.dart';

class TarotScreen extends StatefulWidget {
  const TarotScreen({super.key});

  @override
  State<TarotScreen> createState() => _TarotScreenState();
}

class _TarotScreenState extends State<TarotScreen>
    with TickerProviderStateMixin {
  List<AnimationController> animationControllerList = [];
  List<Animation> animationList = [];

  late List<AnimationStatus> animationStatusList;

  List<String> photoList = [
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_121636047.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_121723644.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_122956544.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_123002379.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_123419121.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_123509076.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_124325849.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_124349305.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_124557557.jpg',
    'http://toyohide.work/BrainLog/UPPHOTO/2021/2021-11-03/20211103_124634632.jpg'
  ];

  ///
  @override
  void initState() {
    super.initState();

    animationControllerList = List.generate(
      10,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ),
    );

    animationStatusList =
        List.generate(10, (index) => AnimationStatus.dismissed);

    animationList = List.generate(
      10,
      (index) => Tween(end: 1.0, begin: 0.0)
          .animate(animationControllerList[index])
        ..addListener(() => setState(() {}))
        ..addStatusListener((status) => animationStatusList[index] = status),
    );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(10, (index) => index).map((e) {
              return Column(
                children: [
                  Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..rotateY(
                        pi * -1 * animationList[e].value - pi,
                      ),
                    child: Card(
                      child: animationList[e].value <= 0.5
                          ? Container(
                              color: Colors.blueAccent,
                              width: 100,
                              height: 200,
                              child: const Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 200,
                              color: Colors.grey,
                              child: Image.network(
                                photoList[e],
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (animationStatusList[e] == AnimationStatus.dismissed) {
                        animationControllerList[e].forward();
                      } else {
                        animationControllerList[e].reverse();
                      }
                    },
                    child: const Text('reverse'),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
