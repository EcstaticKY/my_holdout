import 'package:flutter/material.dart';

class CenterMessageDisplay extends StatelessWidget {
  final String message;

  const CenterMessageDisplay({Key key, @required this.message})
      : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 3,
      child: Center(
        child: Text(message, style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,),
      ),
    );
  }
}