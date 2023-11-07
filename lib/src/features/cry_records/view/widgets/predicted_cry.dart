import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_button.dart';
import 'package:udenwa_prosper/src/components/fu_image.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/alarm_manager.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';

class PredictedCry extends StatefulWidget {
  final DateTime from;
  final DateTime to;
  final AlarmSettings? alarmSettings;
  final void Function() onSetAlarm;
  final void Function() onRefreshAlarm;
  const PredictedCry({super.key, required this.from,
    required this.to, required this.onSetAlarm, this.alarmSettings, required this.onRefreshAlarm});

  @override
  State<PredictedCry> createState() => _PredictedCryState();
}

class _PredictedCryState extends State<PredictedCry> {
  static StreamSubscription? subscription;

  bool deletingAlarm = false;
  AlarmSettings? ringingSettings;

  void updateState(){
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    subscription ??= Alarm.ringStream.stream.listen((alarmSettings) {
      ringingSettings = alarmSettings;
      updateState();
    });
  }

  Future<void> deleteAlarm() async {
    deletingAlarm = true;
    updateState();
    AlarmManager.removeAlarm(alarmSettings: widget.alarmSettings!).then((value){
      deletingAlarm = false;
      ringingSettings = null;
      updateState();
      widget.onRefreshAlarm();
    });
  }

  Widget _baby({bool shouldShake = false}){
    return shouldShake ? FUImage.image(
      assetStringOrUrl: AssetConstants.baby,
    ).animate(
     onComplete: (ctrl)=> ctrl.repeat(),
    ).shake() : FUImage.image(assetStringOrUrl: AssetConstants.baby);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 194,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.primaryColor,
          ),
          child: Column(
            children: [
              const Spacer(),
              _baby(shouldShake: ringingSettings != null),
              gapH5,
              Text("Next Predicted Cry", style: context.theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),),
              gapH5,
              FittedBox(
                child: Text("${widget.from.hour < 10 ? "0" : ""}${widget.from.hour}:${widget.from.minute
                    < 10 ? "0" : ""}${widget.from.minute} - ${widget.to.hour
                    < 10 ? "0" : ""}${widget.to.hour}:${widget.to.minute < 10 ? "0" : ""}${widget.to.minute}",
                  style: context.theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 21, color: AppColor.accentColor, fontWeight: FontWeight.w600),),
              ),
              FUButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: ringingSettings!= null? Colors.white : AppColor.primaryColor,
                  backgroundColor: ringingSettings!= null? AppColor.errorColor : Colors.white.withOpacity(0.71),
                  minimumSize: const Size(100, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: context.theme.textTheme.bodyMedium?.copyWith(fontSize: 10, fontWeight: FontWeight.w500)
                ),
                text: "${widget.alarmSettings == null? "Set" : ringingSettings!= null? "Stop" : "Edit"} Alarm",
                onPressed: (){
                  if (ringingSettings!= null) {
                    deleteAlarm();
                  }  else {
                    widget.onSetAlarm();
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        if(widget.alarmSettings != null)Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 8),
            child: const Icon(
              Icons.alarm, size: 18, color: Colors.white,
            ).animate(
              onComplete: (ctrl)=> ctrl.repeat(),
            ).fadeIn(
              begin: 0.4, duration: 2.seconds,
            ),
          ),
        ),
      ],
    );
  }
}
