import '../entities/subscription.dart';

abstract interface class SubscriptionRepository {
  Future<List<Subscription>> getSubscriptions();
  Future<void> addSubscription(Subscription subscription);
  Future<void> updateSubscription(int id, Subscription subscription);
  Future<void> deleteSubscription(int id);
}