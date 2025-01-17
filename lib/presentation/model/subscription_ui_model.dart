import '../../domain/entities/subscription.dart';

class SubscriptionUIModel {
  String appName;
  double amount;
  DateTime startDate;
  String period;
  bool autoRenewal;

  SubscriptionUIModel({
    this.appName = '',
    this.amount = 0.0,
    required this.startDate,
    required this.period,
    required this.autoRenewal,
  });


  Subscription toSubscription() {
    return Subscription(
      appName: appName,
      amount: amount,
      startDate: startDate,
      period: period,
      autoRenewal: autoRenewal,
    );
  }
}
