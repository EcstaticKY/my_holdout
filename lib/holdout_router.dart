import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_holdout/weather/bloc/weather_bloc.dart';
import 'package:my_holdout/weather/domain/weather_repository.dart';
import 'package:my_holdout/weather/presenter/weather_search_page.dart';

import 'cookbook/animate_a_widget/main_screen.dart';

class HoldoutRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to ZKY's holdout"),
      ),
      body: Center(child: Column(
        children: <Widget>[
          Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) =>
                              WeatherBloc(FakeWeatherRepository()),
                          child: WeatherSearchPage(),
                        ))),
            child: Text('Go to Weather Search'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen())),
            child: Text('Go to animate a widget across screens'),
          ),
          Spacer(),
        ],
      )),
    );
  }
}
