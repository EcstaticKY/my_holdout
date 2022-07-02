import 'package:dartz/dartz.dart';
import 'package:my_holdout/shared/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final convertedInt = int.parse(str);
      return convertedInt >= 0 ? Right(convertedInt) : Left(InvalidInputFailure());
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}