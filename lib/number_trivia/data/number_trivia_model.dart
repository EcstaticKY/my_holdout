import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NumberTriviaModel extends Equatable {
  final int number;
  final String text;

  NumberTriviaModel({@required this.number, @required this.text});

  @override
  List<Object> get props => [number, text];

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(number: json['number'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
    };
  }
}
