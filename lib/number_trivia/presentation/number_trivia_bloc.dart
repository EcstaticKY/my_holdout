import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_holdout/number_trivia/domain/get_concrete_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/get_random_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/number_trivia.dart';
import 'package:my_holdout/shared/util/input_converter.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required InputConverter converter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(converter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        inputConverter = converter,
        super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
        },
      );
    }
  }
}
