import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_holdout/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:my_holdout/tasks_with_moor/data/moor_database.dart';
import 'package:my_holdout/tasks_with_moor/presentation/home_page.dart';
import 'package:my_holdout/weather/bloc/weather_bloc.dart';
import 'package:my_holdout/weather/cubit/weather_cubit.dart';
import 'package:my_holdout/weather/domain/weather_repository.dart';
import 'package:my_holdout/weather/bloc/weather_search_page.dart'
    as weatherBloc;
import 'package:my_holdout/weather/cubit/weather_search_page.dart'
    as weatherCubit;
import 'package:provider/provider.dart';

import 'cookbook/animate_a_widget/main_screen.dart';

class HoldoutRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to ZKY's holdout"),
      ),
      body: Center(
          child: Column(
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
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NumberTriviaPage())),
            child: Text('Go to Number Trivia'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Provider(
                        create: (_) => AppDatabase(),
                        child: MaterialApp(
                          title: 'Tasks App',
                          home: HomePage(),
                        ),
                      )),
            ),
            child: Text('Go to task list'),
          ),
          Spacer(),
        ],
      )),
    );
  }
}
