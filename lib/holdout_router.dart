import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_holdout/weather/bloc/weather_bloc.dart';
import 'package:my_holdout/weather/cubit/weather_cubit.dart';
import 'package:my_holdout/weather/domain/weather_repository.dart';
import 'package:my_holdout/weather/bloc/weather_search_page.dart' as weatherBloc;
import 'package:my_holdout/weather/cubit/weather_search_page.dart' as weatherCubit;

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
                          WeatherCubit(FakeWeatherRepository()),
                      child: weatherCubit.WeatherSearchPage(),
                    ))),
            child: Text('Go to Weather Search Cubit'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) =>
                              WeatherBloc(FakeWeatherRepository()),
                          child: weatherBloc.WeatherSearchPage(),
                        ))),
            child: Text('Go to Weather Search Bloc'),
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
