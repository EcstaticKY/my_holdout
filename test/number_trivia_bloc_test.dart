import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_holdout/number_trivia/domain/get_concrete_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/get_random_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/number_trivia.dart';
import 'package:my_holdout/number_trivia/presentation/number_trivia_bloc.dart';
import 'package:my_holdout/shared/usecase.dart';
import 'package:my_holdout/shared/util/input_converter.dart';
import 'package:my_holdout/shared/error/failure.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        converter: mockInputConverter);
  });

  test('Initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '123';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTrivia(number: 123, text: 'test trivia');

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    test(
        'Should call the InputConverter to validate and convert a string to an unsigned integer.',
        () async {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('Should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      expectLater(bloc, emits(Error(message: INVALID_INPUT_FAILURE_MESSAGE)));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('Should get data from the concrete use case', () async {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia.call(any));

      verify(mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)));
    });

    test('Should emit [Loading, Loaded] when data is gotten successfully', () {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      expectLater(
          bloc, emitsInOrder([Loading(), Loaded(trivia: tNumberTrivia)]));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        'Should emit [Loading, Error] when getting data fails with ServerFailure',
        () async {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      expectLater(bloc,
          emitsInOrder([Loading(), Error(message: SERVER_FAILURE_MESSAGE)]));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        'Should emit [Loading, Error] when getting data fails with CacheFailure',
        () async {
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      expectLater(bloc,
          emitsInOrder([Loading(), Error(message: CACHE_FAILURE_MESSAGE)]));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 123, text: 'test trivia');

    test('Should get data from the random use case', () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia.call(any));

      verify(mockGetRandomNumberTrivia.call(NoParams()));
    });

    test('Should emit [Loading, Loaded] when data is gotten successfully', () {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      expectLater(
          bloc, emitsInOrder([Loading(), Loaded(trivia: tNumberTrivia)]));

      bloc.add(GetTriviaForRandomNumber());
    });

    test(
        'Should emit [Loading, Error] when getting data fails with ServerFailure',
        () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      expectLater(bloc,
          emitsInOrder([Loading(), Error(message: SERVER_FAILURE_MESSAGE)]));

      bloc.add(GetTriviaForRandomNumber());
    });

    test(
        'Should emit [Loading, Error] when getting data fails with CacheFailure',
        () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      expectLater(bloc,
          emitsInOrder([Loading(), Error(message: CACHE_FAILURE_MESSAGE)]));

      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
