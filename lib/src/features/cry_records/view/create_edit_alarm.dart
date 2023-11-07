import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/components/fu_button.dart';
import 'package:udenwa_prosper/src/components/fu_text_button.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/constants/assets_constants.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/alarm_manager.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';

class CreateEditAlarm extends StatefulWidget {
  final AlarmSettings? settings;
  final DateTime? alarmTime;
  const CreateEditAlarm({super.key, this.settings, this.alarmTime});

  @override
  State<CreateEditAlarm> createState() => _CreateEditAlarmState();
}

class _CreateEditAlarmState extends State<CreateEditAlarm> {

  bool snooze = true;
  bool savingAlarm = false;
  bool deletingAlarm = false;

  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.alarmTime ?? widget.settings?.dateTime ?? DateTime.now();
    updateState();
  }

  void updateState(){
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> saveAlarm() async {
    savingAlarm = true;
    updateState();
    final settings = AlarmSettings(
      id: widget.settings == null? DateTime.now().millisecondsSinceEpoch % 10000 : widget.settings!.id,
      dateTime: selectedDateTime,
      assetAudioPath: AssetConstants.marimbaMP3,
      notificationTitle: "Baby Crying",
      notificationBody: "Check on your baby now",
    );
    AlarmManager.setAlarm(alarmSettings: settings).then((value){
      savingAlarm = false;
      updateState();
      context.nav.pop(true);
    });
  }

  Future<void> deleteAlarm() async {
    deletingAlarm = true;
    updateState();
    AlarmManager.removeAlarm(alarmSettings: widget.settings!).then((value){
      deletingAlarm = false;
      updateState();
      context.nav.pop(true);
    });
  }

  Widget _rowWidget({required String left, String right = "",
    VoidCallback? onTap, Widget? rightWidget}){
    return Row(
      children: [
        Text(left,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        rightWidget ?? InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(right,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.7)),
              ),
              gapW4,
              Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white.withOpacity(0.7)),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Column(
        children: [
          gapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FUTextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.accentColor,
                ),
                onPressed: ()=> context.nav.pop(),
                text: "Cancel",
              ),
              gapW12,
              Text("${widget.settings == null? "Set" : "Edit"} Alarm",
                style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              gapW12,
              FUTextButton(
                useCupertino: true,
                isLoading: savingAlarm,
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.accentColor,
                ),
                text: "Save",
                onPressed: ()=> saveAlarm(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15,0,15,20),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: selectedDateTime,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (date){
                        selectedDateTime = selectedDateTime.copyWith(
                          hour: date.hour,
                          minute: date.minute,
                        );
                        if (selectedDateTime.isBefore(DateTime.now())) {
                          selectedDateTime = selectedDateTime.add(1.days);
                        }
                        updateState();
                      },
                    ),
                  ),
                  gapH16,
                  Container(
                    padding: const EdgeInsets.fromLTRB(20,20,20,10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.theme.cardColor
                    ),
                    child: Column(
                      children: [
                        _rowWidget(left: "Repeat", right: "Never"),
                        const Divider(height: 30,),
                        _rowWidget(left: "Label", right: "Next Predicted Cry"),
                        const Divider(height: 30,),
                        _rowWidget(left: "Sound", right: "Circuit"),
                        const Divider(height: 30,),
                        _rowWidget(
                          left: "Snooze",
                          rightWidget: CupertinoSwitch(
                            value: snooze,
                            onChanged: (val){
                              snooze = val;
                              updateState();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH32,
                  if(widget.settings != null)FUButton(
                    useCupertino: true,
                    isLoading: deletingAlarm,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppColor.errorColor,
                        backgroundColor: context.theme.cardColor,
                    ),
                    text: "Delete Alarm",
                    onPressed: ()=> deleteAlarm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
