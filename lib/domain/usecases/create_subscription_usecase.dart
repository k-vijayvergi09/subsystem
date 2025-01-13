import '../entities/subscription.dart';
import '../../data/repository/subscription_repository_impl.dart';

class CreateSubscriptionUseCase {
  final SubscriptionRepositoryImpl repository;

  CreateSubscriptionUseCase(this.repository);

  Future<bool> execute(Subscription subscription) async {
    try {
      final result = await repository.createSubscription(subscription);
      return result > 0;
    } catch (e) {
      return false;
    }
  }
}