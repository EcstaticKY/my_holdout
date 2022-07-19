part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class RefreshTaskListEvent extends TaskListEvent {}