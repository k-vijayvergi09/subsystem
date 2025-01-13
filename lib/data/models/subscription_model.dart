import 'package:hive/hive.dart';

import '../../domain/entities/subscription.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 0)
class SubscriptionModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime dueDate;

  @HiveField(3)
  final String period;

  @HiveField(4)
  final bool autoRenewal;

  @HiveField(5)
  final int? id;

  SubscriptionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.period,
    required this.autoRenewal,
  });

  factory SubscriptionModel.fromDomain(Subscription subscription) {
    return SubscriptionModel(
      id: subscription.id,
      title: subscription.appName,
      amount: subscription.amount,
      dueDate: subscription.startDate,
      period: subscription.period,
      autoRenewal: subscription.autoRenewal,
    );
  }

  Subscription toDomain() {
    return Subscription(
      id: id,
      appName: title,
      amount: amount,
      period: period,
      startDate: dueDate,
      autoRenewal: autoRenewal,
    );
  }
} 