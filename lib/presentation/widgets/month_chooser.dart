import 'package:flutter/material.dart';

class MonthChooser extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onMonthChanged;

  const MonthChooser({
    super.key,
    required this.selectedDate,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              onMonthChanged(
                DateTime(
                  selectedDate.year,
                  selectedDate.month - 1,
                ),
              );
            },
          ),
          Text(
            '${selectedDate.year}년 ${selectedDate.month}월',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              onMonthChanged(
                DateTime(
                  selectedDate.year,
                  selectedDate.month + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 