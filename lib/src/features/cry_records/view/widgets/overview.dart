import 'package:flutter/cupertino.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/models/overview_data.dart';
import 'package:udenwa_prosper/src/res/hex_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';

class OverView extends StatelessWidget {
  final OverViewData data;
  const OverView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor("#132C84"), width: 0.5),
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
                  color: data.imageBgColor,
                ),
                child: FUImage.svgImage(assetStringOrUrl: data.image),
              ),
              gapW8,
              Flexible(
                child: FittedBox(
                  child: Text(data.topText, style: context.theme.textTheme.bodyMedium
                      ?.copyWith(fontSize: 8, fontWeight: FontWeight.w400),),
                ),
              ),
            ],
          ),
          gapH16,
          FittedBox(
            child: Text(data.centreText, style: context.theme.textTheme.bodyMedium
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),),
          ),
          gapH16,
          FittedBox(
            child: Text(data.bottomText, textAlign: TextAlign.center, style: context.theme.textTheme.bodyMedium
                ?.copyWith(fontSize: 7, fontWeight: FontWeight.w400, color: data.bottomTextColor),),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
