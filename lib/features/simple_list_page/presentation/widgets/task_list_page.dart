import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_holdout/features/simple_list_page/domain/get_tasks_usecase.dart';
import 'package:my_holdout/features/simple_list_page/presentation/bloc/task_list_bloc.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
      ),
      body: BlocProvider<TaskListBloc>(
        create: (_) => TaskListBloc(getTasks: GetTasksUseCase()),
        child: Column(
          children: <Widget>[
            BlocBuilder<TaskListBloc, TaskListState>(builder: (context, state) {
              if (state is TaskListLoading) {
                return Text('Loading...');
              } else if (state is TaskListLoaded) {
                return Text('Loaded.');
              } else {
                return Text('Empty.');
              }
            })
          ],
        ),
      ),
    );
  }
}
