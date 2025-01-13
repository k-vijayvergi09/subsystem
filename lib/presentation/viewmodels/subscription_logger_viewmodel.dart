import 'package:flutter/material.dart';
import 'package:subsystem/domain/usecases/create_subscription_usecase.dart';

import '../../data/repository/subscription_repository_impl.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionLoggerViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final amountController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  String _selectedPeriod = 'Monthly';
  bool _autoRenewal = true;
  final CreateSubscriptionUseCase _createSubscriptionUseCase = CreateSubscriptionUseCase(SubscriptionRepositoryImpl());

  final List<String> subscriptionPeriods = [
    'Monthly',
    'Quarterly',
    'Yearly',
  ];

  DateTime get startDate => _startDate;
  String get selectedPeriod => _selectedPeriod;
  bool get autoRenewal => _autoRenewal;

  void updateStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void updateSelectedPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void updateAutoRenewal(bool value) {
    _autoRenewal = value;
    notifyListeners();
  }

  bool validateAndSave() {
    if (formKey.currentState!.validate()) {
      
      return true;
    }
    return false;
  }

  Future<bool> saveSubscription() async {
    if (!formKey.currentState!.validate()) return false;

    final subscription = Subscription(
      appName: appNameController.text,
      amount: double.parse(amountController.text),
      period: selectedPeriod,
      startDate: startDate,
      autoRenewal: autoRenewal,
    );

    final result = await _createSubscriptionUseCase.execute(subscription);
    if (result) {
      appNameController.clear();
      amountController.clear();
      updateStartDate(DateTime.now());
      updateSelectedPeriod('Monthly');
      updateAutoRenewal(true);
    }
    return result;
  }

  @override
  void dispose() {
    appNameController.dispose();
    amountController.dispose();
    super.dispose();
  }
} 