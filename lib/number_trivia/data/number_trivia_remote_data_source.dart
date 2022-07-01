import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_holdout/shared/error/exception.dart';

import 'number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getNumberTriviaFrom('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getNumberTriviaFrom('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getNumberTriviaFrom(String url) async {
    final response = await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Future.value(
          NumberTriviaModel.fromJson(json.decode(response.body)));
    } else {
      throw ServerException();
    }
  }
}