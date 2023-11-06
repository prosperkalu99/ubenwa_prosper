import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/alarm_manager.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/repository/cry_records_repository.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/create_edit_alarm.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/breakdown.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/calender.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/daily_challenge.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/overview.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/predicted_cry.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/res/theme/app_theme.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';
import 'package:collection/collection.dart';

class CryRecordsScreen extends StatefulWidget {
  const CryRecordsScreen({super.key});

  @override
  State<CryRecordsScreen> createState() => _CryRecordsScreenState();
}

class _CryRecordsScreenState extends State<CryRecordsScreen> {

  AlarmSettings? alarmSettings;

  void updateState(){
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getAlarm();
  }

  void getAlarm(){
    alarmSettings = AlarmManager.getAlarm();
    updateState();
  }

  Widget _header(String text){
    return Text(text, style: Theme.of(context).textTheme.bodyMedium
        ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),);
  }

  Future<void> setOrEditAlarm({AlarmSettings? settings, DateTime? alarmTime}) async {
    final res = await showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Theme(
            data: AppTheme.darkTheme,
            child: CreateEditAlarm(
              settings: settings,
              alarmTime: alarmTime,
            ),
          ),
        );
      },
    );
    if (res != null && res) getAlarm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cry Records", style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.secondaryColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20,),
          onPressed: ()=> context.nav.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              onPressed: (){},
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  FUImage.svgImage(assetStringOrUrl: AssetConstants.notification),
                  Positioned(
                    top: 0,
                    right: 3,
                    child: Badge(
                      smallSize: 8,
                      backgroundColor: AppColor.accentColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH16,
            const Calender(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH24,
                  _header("Today’s Overview"),
                  gapH12,
                  Row(
                    children: [
                      ...CryRecordsRepository.overViewDataArray.mapIndexed((index, e) {
                        bool isLast = index == CryRecordsRepository.overViewDataArray.length - 1;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: isLast? 0 : 10
                            ),
                            child: OverView(
                              data: CryRecordsRepository.overViewDataArray[index],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _header("Hourly Breakdown"),
                ),
                gapH12,
                const Breakdown()
              ],
            ),
            gapH24,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: DailyChallenge(),
                  ),
                  gapW16,
                  Expanded(
                    child: PredictedCry(
                      from: DateTime.now(),
                      to: DateTime.now().add(30.minutes),
                      alarmSettings: alarmSettings,
                      onRefreshAlarm: ()=> getAlarm(),
                      onSetAlarm: (){
                        setOrEditAlarm(
                          alarmTime: alarmSettings?.dateTime ?? DateTime.now(),
                          settings: alarmSettings
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}
