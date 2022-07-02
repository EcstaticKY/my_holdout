import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_holdout/number_trivia/domain/get_concrete_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/get_random_number_trivia.dart';
import 'package:my_holdout/number_trivia/presentation/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    bloc = NumberTriviaBloc(concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia);
  });

  test('Initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetConcreteForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);

    test('Should emit [Error] when the input is invalid', () async {
      final tInvalidString = 'uuu';

      expectLater(bloc, emits(Error(message: "Something Wrong here")));

      bloc.add(GetTriviaForConcreteNumber(tInvalidString));
    });
  });
}