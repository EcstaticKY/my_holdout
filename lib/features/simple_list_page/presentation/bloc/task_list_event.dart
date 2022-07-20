part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class RefreshTaskListEvent extends TaskListEvent {}

class LoadedTaskListEvent extends TaskListEvent {
  final List<MyTask> tasks;

  LoadedTaskListEvent(this.tasks);
}