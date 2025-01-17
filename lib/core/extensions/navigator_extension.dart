import 'package:flutter/material.dart';
import '../../presentation/screens/my_subscription_screen.dart';
import '../../presentation/screens/subscription_logger_screen.dart';
import '../../presentation/screens/subscription_list_screen.dart';

enum AppRoute {
  subscriptionLogger,
  subscriptionList,
  mySubscription,
}

extension NavigatorExtension on NavigatorState {
  Future<T?> navigateTo<T>(AppRoute route, {Object? arguments}) {
    return push<T>(
      MaterialPageRoute(
        builder: (_) => _getScreen(route, arguments),
      ),
    );
  }

  Widget _getScreen(AppRoute route, Object? arguments) {
    switch (route) {
      case AppRoute.subscriptionLogger:
        return const SubscriptionLoggerScreen();
      case AppRoute.subscriptionList:
        return const SubscriptionListScreen();
      case AppRoute.mySubscription:
        return const MySubscriptionScreen();
    }
  }
} 