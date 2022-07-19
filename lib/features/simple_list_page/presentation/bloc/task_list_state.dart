part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListEmpty extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<MyTask> tasks;

  TaskListLoaded(this.tasks);
}
