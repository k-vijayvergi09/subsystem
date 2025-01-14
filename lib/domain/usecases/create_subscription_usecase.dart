import '../entities/subscription.dart';
import 'dart:developer' as dev;
import '../repositories/subscription_repository.dart';

class CreateSubscriptionUseCase {
  final SubscriptionRepository repository;

  CreateSubscriptionUseCase(this.repository);

  Future<bool> execute(Subscription subscription) async {
    try {
      dev.log('CreateSubscriptionUseCase: Starting execution');
      
      await repository.addSubscription(subscription);
      
      dev.log('CreateSubscriptionUseCase: Database insert completed');
      
      return true;
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