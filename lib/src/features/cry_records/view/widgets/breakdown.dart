import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';

class Breakdown extends StatefulWidget {
  const Breakdown({super.key});

  @override
  State<Breakdown> createState() => _BreakdownState();
}

class _BreakdownState extends State<Breakdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(10,20,10,10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF4475F6),
            Color(0xFF07236B),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(12, (index) {
            var newValue = index * 2;
            var isEven = index % 2 == 0;
            return Progressbar(
              duration: isEven? 1.seconds : 1.5.seconds,
              progress: isEven? 0.5 : (index/12),
              text: "${newValue < 10? "0" : ""}$newValue : 00/"
                  "\n${newValue < 10? "0" : ""}${newValue + 2} : 00",
            );
          })
        ],
      ),
    );
  }
}

class Progressbar extends StatefulWidget {
  final double progress;
  final Duration duration;
  final String text;
  const Progressbar({super.key, required this.progress,
    required this.text, this.duration = const Duration(seconds: 1)});

  @override
  State<Progressbar> createState() => _ProgressbarState();
}

class _ProgressbarState extends State<Progressbar> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
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

