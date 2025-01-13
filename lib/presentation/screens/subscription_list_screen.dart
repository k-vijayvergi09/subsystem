import 'package:flutter/material.dart';
import '../../domain/entities/subscription.dart';
import '../../data/repository/subscription_repository_impl.dart';
import '../../data/datasources/local/database_helper.dart';


class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({super.key});

  Future<List<Subscription>> _getSubscriptions() async {
    final repository = SubscriptionRepositoryImpl(DatabaseHelper.instance);
    return await repository.getSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription List'),
      ),
      body: FutureBuilder<List<Subscription>>(
        future: _getSubscriptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final subscriptions = snapshot.data ?? [];
          
          if (subscriptions.isEmpty) {
            return const Center(child: Text('No subscriptions found'));
          }

          return ListView.builder(
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              final subscription = subscriptions[index];
              return ListTile(
                title: Text(subscription.appName),
                subtitle: Text(
                  'Amount: \$${subscription.amount.toStringAsFixed(2)}\n'
                  'Period: ${subscription.period}'
                ),
                trailing: Text(
                  subscription.autoRenewal ? 'Auto-renewal' : 'Manual renewal'
                ),
              );
            },
          );
        },
      ),
    );
  }
} 