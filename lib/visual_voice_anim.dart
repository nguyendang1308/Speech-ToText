import 'package:demo/animation/visual_voice.dart';
import 'package:flutter/material.dart';

class VoiceVisualizer extends StatelessWidget {
  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent
  ];
  List<int> duration = [900, 700, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        10,
        (index) => VisualVoice(
          duration: duration[index % 5],
          color: colors[index % 4],
        ),
      ),
    );
  }
}
