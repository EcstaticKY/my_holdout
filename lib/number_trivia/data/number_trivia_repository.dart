import 'package:dartz/dartz.dart';
import 'package:my_holdout/number_trivia/domain/number_trivia.dart';
import 'package:my_holdout/shared/error/failure.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
