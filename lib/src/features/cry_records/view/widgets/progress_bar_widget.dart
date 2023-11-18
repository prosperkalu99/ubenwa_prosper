import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';

class Progressbar extends StatefulWidget {
  final double progress;
  final String text;
  const Progressbar({super.key, required this.progress, required this.text});

  @override
  State<Progressbar> createState() => _ProgressbarState();
}

class _ProgressbarState extends State<Progressbar> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: 2.seconds);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linearToEaseOut);
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 7,
              height: 151,
              decoration: BoxDecoration(
                color: const Color(0x5405226F),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Builder(
                builder: (context) {
                  return Container(
                    width: 7,
                    height: _animation.value * (151 * (widget.progress)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }
            ),
          ],
        ),
        gapH8,
        Text(widget.text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(fontSize: 8, fontWeight: FontWeight.w300, color: Colors.white),)
      ],
    );
  }
}