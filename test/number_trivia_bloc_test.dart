import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_holdout/number_trivia/domain/get_concrete_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/get_random_number_trivia.dart';
import 'package:my_holdout/number_trivia/presentation/number_trivia_bloc.dart';
import 'package:my_holdout/shared/util/input_converter.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter inputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    inputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        converter: inputConverter
    );
  });

  test('Initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '123';
    final tNumberParsed = int.parse(tNumberString);

    test('Should call the InputConverter to validate and convert a string to an unsigned integer.',
            () async {
      when(inputConverter.stringToUnsignedInteger(any)).thenReturn(Right(tNumberParsed));
      
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(inputConverter.stringToUnsignedInteger(any));

      verify(inputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('Should emit [Error] when the input is invalid', () async {
      when(inputConverter.stringToUnsignedInteger(any)).thenReturn(Left(InvalidInputFailure()));

      expectLater(bloc, emits(Error(message: INVALID_INPUT_FAILURE_MESSAGE)));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
}