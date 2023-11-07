
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/onboarding/data/model/onboarding_data.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';

class OnboardingRepository {

  static var onboardingItems = [
    const OnboardingData(
      title: "Welcome to a New\nMothering Experience",
      body: "Now you can understand a lot about your new born, buckle up for an experience you will always long for.",
      image: AssetConstants.obImageOne,
    ),
    const OnboardingData(
      title: "A Cry with Meaning",
      body: "Now with great feedbacks, you can understand a lot about your new born cry patter and prepare for common cry peak period.",
      image: AssetConstants.obImageTwo,
    ),
    const OnboardingData(
      title: "Analytical Insight",
      body: "Be your baby’s doctor by viewing great insight and analysis; "
          "you get to see how your baby cry activity varies in terms of duration and frequency to help you make good decisions",
      image: AssetConstants.obImageThree,
    ),
    const OnboardingData(
      title: "Happy Mom\nHappy Home",
      body: "Reduce you baby crying time whilst getting your schedule back together by planning for time of cry activity and time of quite.",
      image: AssetConstants.obImageFour,
    ),
  ];

  static var babyImages = [
    [
      AssetConstants.baby11,
      AssetConstants.baby12,
      AssetConstants.baby13,
      AssetConstants.baby14,
    ],
    [
      AssetConstants.baby21,
      AssetConstants.baby22,
      AssetConstants.baby23,
      AssetConstants.baby24,
    ],
    [
      AssetConstants.baby31,
      AssetConstants.baby32,
      AssetConstants.baby33,
      AssetConstants.baby34,
    ],
    [
      AssetConstants.baby41,
      AssetConstants.baby42,
      AssetConstants.baby43,
      AssetConstants.baby44,
    ]
  ];
}