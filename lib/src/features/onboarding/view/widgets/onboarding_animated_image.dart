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
  final AnimationController fadeCtrl;
  final double radius;
  final int currentIndex;
  const OnboardingAnimatedImage({super.key, required this.rotationCtrl,
    required this.fadeCtrl, required this.radius, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    double size = context.mediaQuery.size.height/4.6;
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ...OnboardingRepository.babyImages[currentIndex].mapIndexed((index, e){
              return CircularImages(
                angle: index == 0? 0 : (index/4 )*360,
                radius: radius,
                image: e,
                animCtrl: fadeCtrl,
              );
            })
          ],
        ).animate(
          controller: rotationCtrl,
          autoPlay: false,
        ).rotate(
          begin: 0,
          end: 0.25,
        ),
        SizedBox(
          height: size,
          width: size,
          child: FUImage.image(assetStringOrUrl: OnboardingRepository
              .onboardingItems[currentIndex].image, fit: BoxFit.cover).animate(
            controller: fadeCtrl,
            onComplete: (ctrl)=> ctrl.stop(canceled: false),
          ).fadeIn(begin: 0.05, duration: 1.2.seconds),
        ),
      ],
    );
  }
}

class CircularImages extends StatelessWidget {
  final double angle;
  final double radius;
  final String image;
  final AnimationController animCtrl;
  const CircularImages({super.key, required this.angle,
    required this.radius, required this.image, required this.animCtrl});

  @override
  Widget build(BuildContext context) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()..translate((radius) * cos(rad), (radius) * sin(rad)),
      child: FUImage.image(
        assetStringOrUrl: image,
      ).animate(
        controller: animCtrl,
        onComplete: (ctrl)=> ctrl.stop(),
      ).fadeIn(
        begin: 0.01, duration: 1.2.seconds,
      ),
    );
  }
}


