import 'package:flutter/material.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/models/breakdown_data.dart';
import 'package:udenwa_prosper/src/features/cry_records/data/repository/cry_records_repository.dart';
import 'package:udenwa_prosper/src/features/cry_records/view/widgets/progress_bar_widget.dart';

class Breakdown extends StatefulWidget {
  const Breakdown({super.key});

  @override
  State<Breakdown> createState() => _BreakdownState();
}

class _BreakdownState extends State<Breakdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(10,20,10,10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF4475F6),
            Color(0xFF07236B),
          ],
        ),
      ),
      child: ProgressWidget(data: CryRecordsRepository.getBreakDownData()),
    );
  }
}

class ProgressWidget extends StatelessWidget {
  final List<BreakdownData> data;
  const ProgressWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...data.map((e) {
          return Progressbar(
            progress: e.value,
            text: "${e.from.hour < 10? "0" : ""}${e.from.hour} : 00/"
                "\n${e.to.hour < 10? "0" : ""}${e.to.hour} : 00",
          );
        })
      ],
    );
  }
}


