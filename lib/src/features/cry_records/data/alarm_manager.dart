import 'package:alarm/alarm.dart';

class AlarmManager{

  static List<AlarmSettings> getAlarms(){
    var alarms = Alarm.getAlarms();
    if (alarms.isNotEmpty) {
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    }
    return alarms;
  }

  static AlarmSettings? getAlarm(){
    var alarms = Alarm.getAlarms();
    if (alarms.isNotEmpty) {
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    }
    return alarms.isEmpty? null : alarms.first;
  }

  static Future<bool> setAlarm({required AlarmSettings alarmSettings}) async {
    return Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<bool> removeAlarm({required AlarmSettings alarmSettings}) async {
    return Alarm.stop(alarmSettings.id);
  }

}