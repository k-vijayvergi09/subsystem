import '../../domain/entities/subscription.dart';
import '../datasources/local/database_helper.dart';

class SubscriptionRepositoryImpl {
  final dbHelper = DatabaseHelper.instance;

  Future<int> createSubscription(Subscription subscription) async {
    final db = await dbHelper.database;
    return await db.insert('subscriptions', subscription.toMap());
  }
}