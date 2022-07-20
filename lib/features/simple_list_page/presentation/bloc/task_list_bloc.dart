import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_holdout/features/simple_list_page/domain/get_tasks_usecase.dart';
import 'package:my_holdout/features/simple_list_page/domain/my_task.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final GetTasksUseCase getTasks;

  TaskListBloc({@required this.getTasks}) : super(TaskListEmpty());

  @override
  Stream<TaskListState> mapEventToState(TaskListEvent event) async* {
    if (event is RefreshTaskListEvent) {
      yield TaskListLoading();
      getTasks.executeWithCompletion((tasks) {
        add(LoadedTaskListEvent(tasks));
      });
    } else if (event is LoadedTaskListEvent) {
      yield TaskListLoaded(event.tasks);
    }
  }
}
