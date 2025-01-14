import '../../domain/repositories/subscription_repository.dart';
import '../../domain/entities/subscription.dart';
import '../datasources/local/database_helper.dart';
import '../models/subscription_model.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final DatabaseHelper _databaseHelper;

  SubscriptionRepositoryImpl(this._databaseHelper);

  @override
  Future<List<Subscription>> getSubscriptions() async {
    final subscriptions = await _databaseHelper.getAllSubscriptions();
    return subscriptions.map((model) => model.toDomain()).toList();
  }

  @override
  Future<void> addSubscription(Subscription subscription) async {
    await _databaseHelper.addSubscription(
      SubscriptionModel.fromDomain(subscription)
    );
  }

  @override
  Future<void> updateSubscription(int id, Subscription subscription) async {
    await _databaseHelper.updateSubscription(
      id,
      SubscriptionModel.fromDomain(subscription)
    );
  }

  @override
  Future<void> deleteSubscription(int id) async {
    await _databaseHelper.deleteSubscription(id);
  }
}