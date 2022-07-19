import 'package:equatable/equatable.dart';

abstract class SimpleUseCase<T, Params> {
  Future<T> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}