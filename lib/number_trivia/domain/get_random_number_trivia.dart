import 'package:dartz/dartz.dart';
import 'package:my_holdout/shared/error/failure.dart';
import 'package:my_holdout/shared/usecase.dart';

import 'number_trivia.dart';
import '../data/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams noParams) async {
    return await repository.getRandomNumberTrivia();
  }
}
