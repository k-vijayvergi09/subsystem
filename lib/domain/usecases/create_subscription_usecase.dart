import '../entities/subscription.dart';
import '../../data/repository/subscription_repository_impl.dart';
import 'dart:developer' as dev;

class CreateSubscriptionUseCase {
  final SubscriptionRepositoryImpl repository;

  CreateSubscriptionUseCase(this.repository);

  Future<bool> execute(Subscription subscription) async {
    try {
      dev.log('CreateSubscriptionUseCase: Starting execution');
      
      final result = await repository.createSubscription(subscription);
      
      dev.log('CreateSubscriptionUseCase: Database insert result: $result');
      
      return result > 0;
    } catch (e, stackTrace) {
      dev.log(
        'CreateSubscriptionUseCase: Error during execution',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}