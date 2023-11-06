import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/cry_records_screen.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';

class DataGatheringScreen extends StatefulWidget {
  const DataGatheringScreen({super.key});

  @override
  State<DataGatheringScreen> createState() => _DataGatheringScreenState();
}

class _DataGatheringScreenState extends State<DataGatheringScreen> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation.addListener(() => setState(() {}));
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.nav.pushReplacement(_createRoute());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CryRecordsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: AppColor.primaryColor,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Transform.translate(
                offset: const Offset(3.5, 150),
                child: FUImage.image(assetStringOrUrl: AssetConstants.milkDrop),
              ).animate(
                onComplete: (ctrl){
                  animationController.forward();
                },
              ).moveY(
                begin: 0,
                end: 14,
                duration: 2.5.seconds,
              ).then().moveY(
                begin: 14,
                end: context.mediaQuery.size.height * 0.65,
                duration: 3.seconds,
              ),
              FUImage.image(assetStringOrUrl: AssetConstants.babyBottle),
              Center(
                child: Text("Please wait while we\ngather your Baby’s data...",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: 2.seconds,
                  height: (animation.value + 0.2)* context.mediaQuery.size.height,
                  width: context.mediaQuery.size.width,
                  child: FUImage.image(assetStringOrUrl: AssetConstants.milkBottom, width: double.maxFinite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
