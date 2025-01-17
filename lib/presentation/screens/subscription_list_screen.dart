import 'package:change_notifier_base/change_notifier_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/subscription_list_viewmodel.dart';
import '../../data/repository/subscription_repository_impl.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../domain/usecases/get_subscription_list_usecase.dart';

class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionListViewModel(
        GetSubscriptionListUseCase(
          SubscriptionRepositoryImpl(DatabaseHelper.instance)
        )
      )..loadSubscriptions(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subscription List'),
        ),
        body: Consumer<SubscriptionListViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.state == ProviderState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (viewModel.hasError) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            final subscriptions = viewModel.data;
            
            if (subscriptions == null || subscriptions.isEmpty) {
              return const Center(child: Text('No subscriptions found'));
            }

            return ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                // Calculate months active
                final monthsActive = DateTime.now().difference(subscription.startDate).inDays ~/ 30;
                
                return ListTile(
                  title: Text(subscription.appName),
                  subtitle: Text(
                    'Amount: ₹${subscription.amount.toStringAsFixed(2)}\n'
                    'Period: ${subscription.period}\n'
                    'Active since ${monthsActive == 0 ? 'Less than a month' : '$monthsActive ${monthsActive == 1 ? 'month' : 'months'}'}'
                  ),
                  trailing: Text(
                    subscription.autoRenewal ? 'Auto-renewal' : 'Manual renewal'
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 