part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

abstract class TaskActionState extends TaskState {}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadingSuccessState extends TaskState {
  final List<TaskModel> tasks;
  final dynamic loggedInUserName;
  TaskLoadingSuccessState(
      {required this.tasks, required this.loggedInUserName});
}

class TaskErrorState extends TaskState {}
