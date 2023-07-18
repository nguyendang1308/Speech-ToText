import 'package:flutter/material.dart';

class VisualVoice extends StatefulWidget {
  const VisualVoice({super.key, required this.duration, required this.color});
  final int duration;
  final Color color;
  @override
  State<VisualVoice> createState() => _VisualVoiceState();
}

class _VisualVoiceState extends State<VisualVoice>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: animation.value,
    );
  }
}
