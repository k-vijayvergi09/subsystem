import 'package:flutter/material.dart';
import 'package:subsystem/domain/usecases/create_subscription_usecase.dart';
import 'dart:developer' as dev;

import '../../data/repository/subscription_repository_impl.dart';
import '../../domain/entities/subscription.dart';
import '../../data/datasources/local/database_helper.dart';

class SubscriptionLoggerViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final amountController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  String _selectedPeriod = 'Monthly';
  bool _autoRenewal = true;
  final CreateSubscriptionUseCase _createSubscriptionUseCase = CreateSubscriptionUseCase(SubscriptionRepositoryImpl(DatabaseHelper.instance));

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
    dev.log('Starting saveSubscription method');
    
    try {
      if (!formKey.currentState!.validate()) {
        dev.log('Form validation failed');
        return false;
      }

      dev.log('Form validation passed');
      
      // Log the input values
      dev.log('Creating subscription with values:'
          '\nApp Name: ${appNameController.text}'
          '\nAmount: ${amountController.text}'
          '\nPeriod: $selectedPeriod'
          '\nStart Date: $startDate'
          '\nAuto Renewal: $autoRenewal');

      final subscription = Subscription(
        appName: appNameController.text,
        amount: double.parse(amountController.text),
        period: selectedPeriod,
        startDate: startDate,
        autoRenewal: autoRenewal,
      );

      dev.log('Subscription object created successfully');
      dev.log('Attempting to save subscription to database');

      final result = await _createSubscriptionUseCase.execute(subscription);
      
      dev.log('Database operation completed. Result: $result');

      if (result) {
        dev.log('Save successful, clearing form');
        _clearForm();
        dev.log('Form cleared successfully');
      }

      return result;
    } catch (e, stackTrace) {
      dev.log(
        'Error in saveSubscription',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  void _clearForm() {
    appNameController.clear();
    amountController.clear();
    updateStartDate(DateTime.now());
    updateSelectedPeriod('Monthly');
    updateAutoRenewal(true);
  }

  @override
  void dispose() {
    appNameController.dispose();
    amountController.dispose();
    super.dispose();
  }
} 