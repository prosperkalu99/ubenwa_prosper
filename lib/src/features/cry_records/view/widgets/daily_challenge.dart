import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/res/hex_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';

class DailyChallenge extends StatelessWidget {
  const DailyChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor("#FFB6B6B6"), width: 0.5),
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor('#FFFAE6B4'),
                ),
                child: FUImage.svgImage(assetStringOrUrl: AssetConstants.star),
              ),
              gapW8,
              Flexible(
                child: FittedBox(
                  child: Text("Daily Challenge", style: context.theme.textTheme.bodyMedium
                      ?.copyWith(fontSize: 11, fontWeight: FontWeight.w500),),
                ),
              ),
            ],
          ),
          gapH20,
          SizedBox(
            height: 108,
            width: 108,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: CustomPaint(
                    painter: RingPainter(
                      progress: 0.58,
                      taskNotCompletedColor: AppColor.disabledColor.withOpacity(0.2),
                      taskCompletedColor: AppColor.accentColor,
                    ),
                  ),
                ),
                Container(
                  height: 108 - 32,
                  width: 108 - 32,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(color: AppColor.disabledColor.withOpacity(0.15),
                          offset: const Offset(0, 2), spreadRadius: 10, blurRadius: 5)
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("8", style: context.theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("out of 12\nhours of silence", textAlign: TextAlign.center,
                        style: context.theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: 7, fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.taskNotCompletedColor,
    required this.taskCompletedColor,
  });
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    const strokeWidth = 16.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
