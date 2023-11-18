import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_button.dart';
import 'package:udenwa_prosper/src/components/fu_text_button.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/features/data_gathering/view/data_gathering_screen.dart';
import 'package:udenwa_prosper/src/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:udenwa_prosper/src/features/onboarding/view/widgets/onboarding_animated_image.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';
import 'package:collection/collection.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>  with TickerProviderStateMixin {
  late AnimationController rotationCtrl;
  late AnimationController slideCtrl;
  late AnimationController fadeCtrl;
  late Animation slideAnimation;

  int pageIndex = 0;

  double posX = 0.0;


  @override
  void initState() {
    super.initState();
    rotationCtrl = AnimationController(duration: 0.5.seconds, vsync: this);
    fadeCtrl = AnimationController(duration: 1.seconds, vsync: this);
    slideCtrl = AnimationController(duration: 0.2.seconds, upperBound: 0.45, lowerBound: 0.3, vsync: this);
    slideAnimation = CurvedAnimation(parent: slideCtrl, curve: Curves.linear, reverseCurve: Curves.linear);
  }

  @override
  void dispose() {
    rotationCtrl.dispose();
    fadeCtrl.dispose();
    slideCtrl.dispose();
    super.dispose();
  }

  void updateState(){
    if (mounted) {
      setState(() {});
    }
  }

  void previous(){
    if (pageIndex > 0) {
      pageIndex--;
      updateState();

      performSlideAnimation();

      rotationCtrl.value = rotationCtrl.upperBound;
      rotationCtrl.reverse();

      fadeCtrl.reset();
      fadeCtrl.forward();
    }
  }

  void next(){
    if(pageIndex < 3) {
      pageIndex++;
      updateState();

      performSlideAnimation();

      rotationCtrl.forward().whenComplete(()=> rotationCtrl.reset());

      fadeCtrl.reset();
      fadeCtrl.forward();
    }
  }

  void performSlideAnimation(){
    slideCtrl.forward().whenComplete(()=> slideCtrl.reverse());
  }

  void _swipe({required DragEndDetails details}){
    if (details.primaryVelocity == null) {
      return;
    }
    if (details.primaryVelocity! < 0) {
      next();
    }
    if (details.primaryVelocity! > 0) {
      previous();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Flexible(
              flex: 3,
              child: Center(
                child: GestureDetector(
                  onHorizontalDragEnd: (details)=> _swipe(details: details),
                  child: OnboardingAnimatedImage(
                    rotationCtrl: rotationCtrl,
                    fadeCtrl: fadeCtrl,
                    slideAnim: slideAnimation,
                    radius: context.mediaQuery.size.height/5.8,
                    currentIndex: pageIndex,
                  ),
                ),
              ),
            ),
            gapH64,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...OnboardingRepository.onboardingItems.mapIndexed((index, e) {
                  bool isAccent = pageIndex == 0 || pageIndex == 2;
                  bool isCurrent = pageIndex == index;
                  return AnimatedContainer(
                    duration: 0.5.seconds,
                    height: 6,
                    width: isCurrent? 15 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: isCurrent && isAccent? AppColor.accentColor : isCurrent && !isAccent
                          ? AppColor.primaryColor : AppColor.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  );
                })
              ],
            ),
            gapH48,
            Text(OnboardingRepository.onboardingItems[pageIndex].title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 22),
            ).animate(
              controller: fadeCtrl,
            ).fadeIn(
              begin: 0.05, duration: 1.2.seconds,
            ),
            gapH12,
            Text(OnboardingRepository.onboardingItems[pageIndex].body,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
            ).animate(
              controller: fadeCtrl,
            ).fadeIn(
              begin: 0.05, duration: 1.2.seconds,
            ),
            if(pageIndex < 3)const Spacer(),
            Visibility(
              visible: pageIndex == 3,
              child: Column(
                children: [
                  gapH48,
                  FUButton(
                    text: "Get Started",
                    onPressed: ()=> context.nav.push(
                      MaterialPageRoute(builder: (context)=> const DataGatheringScreen()),
                    ),
                  ).animate(
                    controller: fadeCtrl,
                  ).fadeIn(
                    begin: 0.05, duration: 1.2.seconds,
                  ),
                  gapH48,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: pageIndex>0,
                  child: Flexible(
                    child: FUTextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(50, 20),
                        foregroundColor: AppColor.textColor,
                      ),
                      text: "Previous",
                      onPressed: ()=> previous(),
                    ).animate().fadeIn(
                      begin: 0.05, duration: 1.2.seconds,
                    ),
                  ),
                ),
                Visibility(
                  visible: pageIndex<3,
                  child: Flexible(
                    child: FUTextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(50, 20),
                      ),
                      text: pageIndex == 0? "Show Me How" : "Next",
                      onPressed: ()=> next(),
                    ).animate().fadeIn(
                      begin: 0.05, duration: 1.2.seconds,
                    ),
                  ),
                ),
              ],
            ),
            gapH20,
          ],
        ),
      ),
    );
  }
}

