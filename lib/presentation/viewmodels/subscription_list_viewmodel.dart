import 'package:change_notifier_base/change_notifier_base.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/usecases/get_subscription_list_usecase.dart';

class SubscriptionListViewModel extends BaseChangeNotifier<List<Subscription>, String> {
  final GetSubscriptionListUseCase _getSubscriptionsUseCase;

  SubscriptionListViewModel(this._getSubscriptionsUseCase);

  Future<void> loadSubscriptions() async {
    try {
      await run(() async { 
        final response = await _getSubscriptionsUseCase.execute();
        data = response;
      });
    } catch (e) {
      error = e.toString();
    }
  }
}