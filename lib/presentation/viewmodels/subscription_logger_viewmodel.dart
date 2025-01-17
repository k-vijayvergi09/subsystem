import 'package:change_notifier_base/change_notifier_base.dart';
import 'package:flutter/material.dart';
import 'package:subsystem/domain/usecases/create_subscription_usecase.dart';
import 'dart:developer' as dev;

import '../../data/repository/subscription_repository_impl.dart';
import '../../data/datasources/local/database_helper.dart';
import '../model/subscription_ui_model.dart';

class SubscriptionLoggerViewModel extends BaseChangeNotifier<Map<String, dynamic>, String> {
  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final amountController = TextEditingController();
  final CreateSubscriptionUseCase _createSubscriptionUseCase = CreateSubscriptionUseCase(SubscriptionRepositoryImpl(DatabaseHelper.instance));
  final SubscriptionUIModel _subscriptionUIModel = SubscriptionUIModel(
      startDate: DateTime.now(),
      period: "Monthly",
      autoRenewal: true,
    );

  SubscriptionLoggerViewModel() {
    initData();
  }

  void initData() {
    data = {
      "startDate": DateTime.now(),
      "period": "Monthly",
      "autoRenewal": true,
    };
  }

  final List<String> subscriptionPeriods = [
    'Monthly',
    'Quarterly',
    'Yearly',
  ];

  void updateField(String key, dynamic value) {
    data![key] = value;
  }

  bool validateAndSave() => formKey.currentState!.validate();

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
          '\nPeriod: ${data!["period"]}'
          '\nStart Date: ${data!["startDate"]}'
          '\nAuto Renewal: ${data!["autoRenewal"]}');
      
      _subscriptionUIModel.appName = appNameController.text;
      _subscriptionUIModel.amount = double.parse(amountController.text);
      _subscriptionUIModel.startDate = data!["startDate"];
      _subscriptionUIModel.period = data!["period"];
      _subscriptionUIModel.autoRenewal = data!["autoRenewal"];


      final subscription = _subscriptionUIModel.toSubscription();

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
    initData();
  }

  @override
  void dispose() {
    appNameController.dispose();
    amountController.dispose();
    super.dispose();
  }
} 