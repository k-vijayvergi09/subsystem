import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/subscription_logger_viewmodel.dart';

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
              TextFormField(
                controller: viewModel.appNameController,
                decoration: const InputDecoration(
                  labelText: 'App/Service Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter app name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.amountController,
                decoration: const InputDecoration(
                  labelText: 'Subscription Amount',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: viewModel.selectedPeriod,
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
                    viewModel.updateSelectedPeriod(newValue);
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Date'),
                subtitle: Text(viewModel.startDate.toString().split(' ')[0]),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: viewModel.startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      viewModel.updateStartDate(picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Auto Renewal'),
                value: viewModel.autoRenewal,
                onChanged: viewModel.updateAutoRenewal,
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
            ],
          ),
        ),
      ),
    );
  }
} 