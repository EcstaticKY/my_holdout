import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_holdout/shared/error/failure.dart';
import 'package:my_holdout/shared/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    
    test('Should return an integer when the string represents an unsigned integer', () {
      final result = inputConverter.stringToUnsignedInteger('123');
      expect(result, equals(Right(123)));
    });
    
    test('Should return a failure when the string is a negative integer', () {
      final result = inputConverter.stringToUnsignedInteger('abc');
      expect(result, equals(Left(InvalidInputFailure())));
    });

    test('Should return a failure when the string is not an integer', () {
      final result = inputConverter.stringToUnsignedInteger('-123');
      expect(result, equals(Left(InvalidInputFailure())));
    });
  });
}