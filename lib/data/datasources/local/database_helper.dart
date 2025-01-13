import 'package:hive_flutter/hive_flutter.dart';
import '../../models/subscription_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static const String subscriptionBoxName = 'subscriptions';
  
  DatabaseHelper._init();

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    // Register the SubscriptionModel adapter
    if (!Hive.isAdapterRegistered(0)) {  // Use a unique typeId
      Hive.registerAdapter(SubscriptionModelAdapter());
    }
    await Hive.openBox<SubscriptionModel>(subscriptionBoxName);
  }

  Future<Box<SubscriptionModel>> get subscriptionsBox async {
    return await Hive.openBox<SubscriptionModel>(subscriptionBoxName);
  }

  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    final box = await subscriptionsBox;
    return box.values.toList();
  }

  Future<void> addSubscription(SubscriptionModel subscription) async {
    final box = await subscriptionsBox;
    await box.add(subscription);
  }

  Future<void> updateSubscription(int key, SubscriptionModel subscription) async {
    final box = await subscriptionsBox;
    await box.put(key, subscription);
  }

  Future<void> deleteSubscription(int key) async {
    final box = await subscriptionsBox;
    await box.delete(key);
  }
}