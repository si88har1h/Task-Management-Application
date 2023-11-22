// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskInitialEvent extends TaskEvent {
  final int userId;
  TaskInitialEvent({
    required this.userId,
  });
}

// class ReloadTaskListEvent extends TaskEvent {
//   final String title;
//   final String description;
//   final String dueDate;
//   final String asignee;
//   final String priority;
//   final String assigner;
//   final String status;
//   final String id;

//   ReloadTaskListEvent({
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.asignee,
//     required this.priority,
//     required this.assigner,
//     required this.status,
//     required this.id,
//   });
// }

class DispatchUserDataEvent extends TaskEvent {
  final String userId;
  DispatchUserDataEvent({
    required this.userId,
  });
}

class AddTaskButtonClickedEvent extends TaskEvent {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String asignee;
  final String status;
  final String id;
  final String assigner;
  AddTaskButtonClickedEvent({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.asignee,
    required this.status,
    required this.id,
    required this.assigner,
  });
}

class CompletedButtonClickedEvent extends TaskEvent {
  final String title;
  final String description;
  final String asignee;
  final String dueDate;
  final String priority;
  final String assigner;
  final String status;
  final String id;
  CompletedButtonClickedEvent({
    required this.title,
    required this.description,
    required this.asignee,
    required this.dueDate,
    required this.priority,
    required this.assigner,
    required this.status,
    required this.id,
  });
}
