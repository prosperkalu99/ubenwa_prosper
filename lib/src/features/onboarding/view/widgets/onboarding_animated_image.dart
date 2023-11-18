import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:collection/collection.dart';

class OnboardingAnimatedImage extends StatelessWidget {
  final AnimationController rotationCtrl;
  final Animation slideAnim;
  final AnimationController fadeCtrl;
  final double radius;
  final int currentIndex;
  const OnboardingAnimatedImage({super.key, required this.rotationCtrl,
    required this.fadeCtrl, required this.radius, required this.currentIndex, required this.slideAnim});

  @override
  Widget build(BuildContext context) {
    double size = context.mediaQuery.size.height/4.6;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: FUImage.image(assetStringOrUrl: OnboardingRepository
              .onboardingItems[currentIndex].image, fit: BoxFit.cover).animate(
            controller: fadeCtrl,
            onComplete: (ctrl)=> ctrl.stop(canceled: false),
          ).fadeIn(begin: 0.05, duration: 1.2.seconds),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            ...OnboardingRepository.babyImages[currentIndex].mapIndexed((index, e){
              return CircularImages(
                angle: index == 0? 0 : (index/4 )*360,
                radius: radius,
                image: e,
                ctrl: slideAnim,
              );
            })
          ],
        ).animate(
          controller: rotationCtrl,
          autoPlay: false,
        ).rotate(
          begin: 0,
          end: 0.25,
          duration: 0.2.seconds,
        ),
      ],
    );
  }
}

class CircularImages extends StatelessWidget {
  final double angle;
  final double radius;
  final String image;
  final Animation ctrl;
  const CircularImages({super.key, required this.angle,
    required this.radius, required this.image, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final double rad = radians(angle);
    final double x = radius * cos(rad);
    final double y = radius * sin(rad);
    return AnimatedBuilder(
      animation: ctrl,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(x * 0.3/ctrl.value, y * 0.3/ctrl.value),
          child: child,
        );
      },
      child: FUImage.image(
        assetStringOrUrl: image,
      ),
    );
  }
}


