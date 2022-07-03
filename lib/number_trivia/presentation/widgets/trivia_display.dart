import 'package:flutter/material.dart';
import 'package:my_holdout/number_trivia/domain/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;

  TriviaDisplay({@required this.trivia}) : assert(trivia != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            trivia.number.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Center(
            child: SingleChildScrollView(
              child: Text(
                trivia.text,
                style:TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ))
        ],
      ),
    );
  }
}