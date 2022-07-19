import 'dart:async';

class CompositeSubscription {
  bool _isDisposed = false;

  final List<StreamSubscription<dynamic>> _subscriptionList = [];

  bool get isDisposed => _isDisposed;

  StreamSubscription<T> add<T>(StreamSubscription<T> subscription) {
    if (isDisposed) {
      throw ('This composite is disposed, try to use instance instead.');
    }
    _subscriptionList.add(subscription);
    return subscription;
  }

  void remove(StreamSubscription<dynamic> subscription) {
    subscription.cancel();
    _subscriptionList.remove(subscription);
  }

  void clear() {
    _subscriptionList.forEach((subscription) {
      subscription.cancel();
    });
    _subscriptionList.clear();
  }

  void dispose() {
    clear();
    _isDisposed = true;
  }
}
