import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_model.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_remote_data_source.dart';
import 'package:my_holdout/number_trivia/domain/number_trivia.dart';
import 'package:my_holdout/shared/error/exception.dart';
import 'package:my_holdout/shared/error/failure.dart';
import 'package:my_holdout/shared/network_info.dart';

import 'number_trivia_local_data_source.dart';
import 'number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getNumberTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getNumberTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final triviaModel = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(triviaModel);
        return Right(_map(triviaModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final triviaModel = await localDataSource.getLastNumberTrivia();
        return Right(_map(triviaModel));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  NumberTrivia _map(NumberTriviaModel model) {
    if (model == null) {
      return null;
    } else {
      return NumberTrivia(text: model.text, number: model.number);
    }
  }
}
