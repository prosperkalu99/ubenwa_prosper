import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/models/overviewData.dart';
import 'package:udenwa_prosper/src/res/hex_color.dart';

class CryRecordsRepository{

  static var overViewDataArray = [
    OverViewData(
      image: AssetConstants.sunFog,
      imageBgColor: HexColor("#D5E0FE"),
      topText: 'Number\nof Cry Episode',
      centreText: "45",
      bottomText: "20% better than yesterday",
      bottomTextColor: HexColor("#14833D"),
    ),
    OverViewData(
      image: AssetConstants.wifiSquare,
      imageBgColor: HexColor("#FEF5D5"),
      topText: 'Longest\nCry Duration',
      centreText: "30mins",
      bottomText: "20% worst than yesterday",
      bottomTextColor: HexColor("#D60F0F"),
    ),
    OverViewData(
      image: AssetConstants.chart,
      imageBgColor: HexColor("#ECD5FE"),
      topText: 'Cumulative\nCry Duration',
      centreText: "4hours",
      bottomText: "20% better than yesterday",
      bottomTextColor: HexColor("#14833D"),
    ),
  ];
}