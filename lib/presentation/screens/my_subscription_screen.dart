import 'package:change_notifier_base/change_notifier_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subsystem/core/extensions/navigator_extension.dart';
import 'package:subsystem/data/repository/subscription_repository_impl.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../domain/usecases/get_subscription_list_usecase.dart';
import '../viewmodels/subscription_list_viewmodel.dart';
import '../widgets/subscription_card.dart';
import '../widgets/subscription_calendar_view.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionListViewModel(
        GetSubscriptionListUseCase(
          SubscriptionRepositoryImpl(
            DatabaseHelper.instance
            )))..loadSubscriptions(),
      child: const _MySubscriptionView(),
    );
  }
}

class _MySubscriptionView extends StatelessWidget {
  const _MySubscriptionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscriptions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {
              Navigator.of(context).navigateTo(AppRoute.subscriptionLogger);
            },
          ),
        ],
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

          return Column(
            children: [
              Expanded(
                flex: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = subscriptions[index];
                    return SubscriptionCard(subscription: subscription);
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: SubscriptionCalendarView(subscriptions: subscriptions),
              ),
            ],
          );
        },
      ),
    );
  }
} 