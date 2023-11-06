import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
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
    double size = context.mediaQuery.size.height/6;
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ...OnboardingRepository.babyImages.mapIndexed((index, e){
              return _buildImage(
                angle: index == 0? 0 : (index/4 )*360,
                color: e.color,
                image: e.image,
              );
            })
          ],
        ).animate(
          controller: rotationCtrl,
          autoPlay: false,
        ).rotate(
          begin: 0,
          end: 1,
        ),
        SizedBox(
          height: size,
          width: size,
          child: FUImage.image(assetStringOrUrl: OnboardingRepository
              .onboardingItems[currentIndex].image, fit: BoxFit.cover).animate(
            controller: fadeCtrl,
            autoPlay: true,
            onComplete: (ctrl)=> ctrl.stop()
          ).fadeIn(begin: 0.05, duration: 1.2.seconds),
        ),
      ],
    );
  }

  _buildImage({required double angle, required Color color, required String image}) {
    final double rad = radians(angle);
    var babyAngle90 = pi/2;
    var babyAngle180 = pi;
    var babyAngle270 = pi + 90;
    return Transform(
      transform: Matrix4.identity()..translate((radius) * cos(rad), (radius) * sin(rad)),
      child: Container(
        height: 57,
        width: 57,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Transform.rotate(
            angle: angle == 90? babyAngle90 : angle == 180? babyAngle180 : angle == 270? babyAngle270 : 0,
            child: FUImage.image(assetStringOrUrl: image),
          ),
        ),
      )
    ).animate(
      controller: fadeCtrl,
    ).fadeIn(
      begin: 0.05, duration: 1.2.seconds,
    );
  }
}

