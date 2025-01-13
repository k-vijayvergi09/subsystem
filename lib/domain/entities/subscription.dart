class Subscription {
  final int? id;
  final String appName;
  final double amount;
  final String period;
  final DateTime startDate;
  final bool autoRenewal;

  Subscription({
    this.id,
    required this.appName,
    required this.amount,
    required this.period,
    required this.startDate,
    required this.autoRenewal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'app_name': appName,
      'amount': amount,
      'period': period,
      'start_date': startDate.toIso8601String(),
      'auto_renewal': autoRenewal ? 1 : 0,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      appName: map['app_name'],
      amount: map['amount'],
      period: map['period'],
      startDate: DateTime.parse(map['start_date']),
      autoRenewal: map['auto_renewal'] == 1,
    );
  }
}