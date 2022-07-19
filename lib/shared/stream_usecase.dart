import 'dart:async';

import 'package:logger/logger.dart';
import 'package:my_holdout/shared/composite_subscription.dart';

import 'observer.dart';

abstract class StreamUseCase<T, Params> {
  CompositeSubscription _disposable;

  Logger _logger;

  Logger get logger => _logger;

  StreamUseCase()
      : _logger = Logger(),
        _disposable = CompositeSubscription();

  Future<Stream<T>> buildUseCaseStream(Params params);

  void execute(Observer<T> observer, [Params params]) async {
    final StreamSubscription subscription = (await buildUseCaseStream(params))
        .listen(observer.onNext,
            onDone: observer.onComplete, onError: observer.onError);
    _disposable.add(subscription);
  }

  void dispose() {
    if (!_disposable.isDisposed) {
      logger.d('Disposing $runtimeType');
      _disposable.dispose();
    }
  }

  void _addSubscription(StreamSubscription subscription) {
    if (_disposable.isDisposed) {
      _disposable = CompositeSubscription();
    }
    _disposable.add(subscription);
  }
}

abstract class CompletableUseCase<Params> extends StreamUseCase<void, Params> {
  Future<Stream<void>> buildUseCaseStream(Params params);
}
