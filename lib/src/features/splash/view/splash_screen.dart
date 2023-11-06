import 'dart:async';

import 'package:flutter/material.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/onboarding/view/onboarding_screen.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () => navigationPage());
  }

  void navigationPage(){
    context.nav.pushReplacement(
      MaterialPageRoute(builder: (context)=> const OnBoardingScreen())
    );
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    startTime();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColor.primaryColor,
        child: Center(child: FUImage.svgImage(assetStringOrUrl: AssetConstants.appLogoSvg, width: animation.value * 200,)),
      ),
    );
  }
}
