import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:udenwa_prosper/src/constants/app_sizes.dart';
import 'package:udenwa_prosper/src/res/app_color.dart';
import 'package:udenwa_prosper/src/res/hex_color.dart';
import 'package:udenwa_prosper/src/utils/extensions/build_context_extensions.dart';
import 'package:collection/collection.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late ScrollController monthScrollCtrl;
  late ScrollController dayScrollCtrl;

  var cryRecords = [
    DateTime(DateTime.now().year, DateTime.now().month, 3),
  ];

  var currentDate = DateTime(DateTime.now().year, DateTime.now().month);
  var currentYear = DateTime.now().year;

  var months  = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec",
  ];

  var days  = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  int getDaysInMonth(int year, int month){
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(1.days);
    int daysInMonth = lastDayOfCurrentMonth.day;
    return daysInMonth;
  }

  void updateState(){
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    monthScrollCtrl = ScrollController(
      initialScrollOffset: currentDate.month <= 3? 0 : currentDate.month <= 8? 60 : 200,
    );
    dayScrollCtrl = ScrollController(
      initialScrollOffset: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          controller: monthScrollCtrl,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...months.mapIndexed((index, e){
                bool isToday = currentDate.month == index + 1;
                return InkWell(
                  onTap: (){
                    currentDate = DateTime(currentYear, index + 1);
                    dayScrollCtrl.animateTo(0, duration: 0.5.seconds, curve: Curves.linearToEaseOut);
                    updateState();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(e, style: context.theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: isToday? FontWeight.w600 : FontWeight.w300,
                        fontSize: 17, color: isToday? AppColor.primaryColor : AppColor.disabledColor),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        gapH16,
        SingleChildScrollView(
          controller: dayScrollCtrl,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(getDaysInMonth(currentYear, currentDate.month), (index){
                bool hasRecord = cryRecords.any((e) => (e.month == currentDate.month) && (e.day == index + 1));
                return SizedBox(
                  height: 95,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedContainer(
                        height: 85,
                        width: 40,
                        duration: 0.5.seconds,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: hasRecord? AppColor.primaryColor : AppColor.disabledColor.withOpacity(0.12),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(43),
                            bottom: Radius.circular(43),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(days[DateTime(currentYear, currentDate.month, index + 1).weekday - 1],
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11, color: hasRecord? Colors.white : AppColor.textColor.withOpacity(0.9),
                                ),
                            ),
                            gapH5,
                            Text("${index + 1}", style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: hasRecord? FontWeight.w700 : FontWeight.w400,
                              fontSize: 17, color: hasRecord? Colors.white : AppColor.textColor.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                      if(hasRecord)Positioned(
                        top: 0,
                        child: Badge(smallSize: 12, backgroundColor: HexColor("#FFB300")),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
