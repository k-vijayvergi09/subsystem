import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../domain/entities/subscription.dart';
import './month_chooser.dart';

class SubscriptionCalendarView extends StatefulWidget {
  final List<Subscription> subscriptions;

  const SubscriptionCalendarView({
    super.key,
    required this.subscriptions,
  });

  @override
  State<SubscriptionCalendarView> createState() => _SubscriptionCalendarViewState();
}

class _SubscriptionCalendarViewState extends State<SubscriptionCalendarView> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final borderDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 0.05,
      ),
      shape: BoxShape.rectangle,
    );

    return Column(
      children: [
        MonthChooser(
          selectedDate: _focusedDay,
          onMonthChanged: (date) {
            setState(() {
              _focusedDay = date;
            });
          },
        ),
        Card(
          child: TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            daysOfWeekHeight: 0,
            rowHeight: 80,
            eventLoader: (day) {
              return widget.subscriptions.where((subscription) {
                final renewalDate = subscription.startDate;
                return renewalDate.year == day.year &&
                       renewalDate.month == day.month &&
                       renewalDate.day == day.day;
              }).toList();
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              todayTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              selectedDecoration: borderDecoration.copyWith(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              todayDecoration: borderDecoration.copyWith(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              defaultDecoration: borderDecoration,
              weekendDecoration: borderDecoration,
              outsideDecoration: borderDecoration,
              markerDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2),
              ),
              markersMaxCount: 4,
              markerSize: 6,
              markerMargin: const EdgeInsets.all(2),
              cellMargin: EdgeInsets.zero,
              cellPadding: EdgeInsets.zero,
              tablePadding: EdgeInsets.zero,
            ),
            headerVisible: false,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
        ),
      ],
    );
  }
} 