import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionCalendarView extends StatelessWidget {
  final List<Subscription> subscriptions;

  const SubscriptionCalendarView({
    super.key,
    required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: DateTime.now(),
        eventLoader: (day) {
          return subscriptions.where((subscription) {
            final renewalDate = subscription.startDate;
            return renewalDate.year == day.year &&
                   renewalDate.month == day.month &&
                   renewalDate.day == day.day;
          }).toList();
        },
        calendarStyle: const CalendarStyle(
          markerDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
} 