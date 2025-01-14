import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionListUseCase {
  final SubscriptionRepository _repository;

  GetSubscriptionListUseCase(this._repository);

  Future<List<Subscription>> execute() async {
    return await _repository.getSubscriptions();
  }
}