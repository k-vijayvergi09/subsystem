import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/navigator_extension.dart';
import '../viewmodels/subscription_logger_viewmodel.dart';
import '../widgets/logger_field.dart';
import '../../core/utils/form_validator.dart';

class SubscriptionLoggerScreen extends StatelessWidget {
  const SubscriptionLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionLoggerViewModel(),
      child: const _SubscriptionLoggerView(),
    );
  }
}

class _SubscriptionLoggerView extends StatelessWidget {
  const _SubscriptionLoggerView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubscriptionLoggerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Subscription'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: viewModel.formKey,
          child: ListView(
            children: [
              LoggerField(
                controller: viewModel.appNameController,
                labelText: 'App/Service Name',
                validator: (value) => FormValidator.validateRequired(
                  value,
                  'App/Service Name'
                ),
              ),
              const SizedBox(height: 16),
              LoggerField(
                controller: viewModel.amountController,
                labelText: 'Subscription Amount',
                prefixText: '₹',
                keyboardType: TextInputType.number,
                validator: (value) => FormValidator.validateNumber(
                  value,
                  'Subscription Amount'
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: viewModel.data!["period"],
                decoration: const InputDecoration(
                  labelText: 'Subscription Period',
                  border: OutlineInputBorder(),
                ),
                items: viewModel.subscriptionPeriods.map((String period) {
                  return DropdownMenuItem(
                    value: period,
                    child: Text(period),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.updateField("period", newValue);
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Date'),
                subtitle: Text(viewModel.data!["startDate"].toString().split(' ')[0]),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: viewModel.data!["startDate"],
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      viewModel.updateField("startDate", picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Auto Renewal'),
                value: viewModel.data!["autoRenewal"],
                onChanged: (value) {
                  viewModel.updateField("autoRenewal", value);
                }
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final success = await viewModel.saveSubscription();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? 'Subscription saved successfully' : 'Failed to save subscription'
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Save Subscription'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).navigateTo(AppRoute.subscriptionList),
                child: const Text('Show Subscription List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 