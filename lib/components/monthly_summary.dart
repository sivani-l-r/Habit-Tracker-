import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    Key? key,
    required this.datasets,
    required this.startDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey,
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(255, 124, 237, 127),
          2: Color.fromARGB(255, 92, 241, 97),
          3: Color.fromARGB(255, 65, 241, 70),
          4: Color.fromARGB(255, 49, 238, 58),
          5: Color.fromARGB(255, 52, 163, 57),
          6: Color.fromARGB(255, 43, 142, 47),
          7: Color.fromARGB(255, 42, 127, 46),
          8: Color.fromARGB(255, 44, 128, 48),
          9: Color.fromARGB(255, 34, 110, 38),
          10: Color.fromARGB(255, 24, 82, 28),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value.toString())),
          );
        },
      ),
    );
  }
}
