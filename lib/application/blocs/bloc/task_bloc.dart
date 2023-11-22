import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss/models/task_model.dart';
import 'package:sss/utils/functions.dart';
import 'package:sss/utils/http_service.dart';
import 'package:sss/utils/functions.dart' as functions;
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskInitialEvent>(taskInitialEvent);
    // on<ReloadTaskListEvent>(reloadTaskListEvent);
    on<CompletedButtonClickedEvent>(completedButtonClickedEvent);
    on<AddTaskButtonClickedEvent>(addTaskButtonClickedEvent);
    on<DispatchUserDataEvent>(dispatchUserDataEvent);
  }

  List<TaskModel> fetchedTasksList = [];
  String loggedInUserId = '';
  dynamic loggedInUserName = '';

  FutureOr<void> completedButtonClickedEvent(
      CompletedButtonClickedEvent event, Emitter<TaskState> emit) async {
    HttpService httpService = HttpService();
    var prefs = await SharedPreferences.getInstance();
    try {
      await httpService.sendCompletedTaskData(
          event.title,
          event.description,
          event.asignee,
          event.dueDate,
          event.priority,
          event.assigner,
          'Complete',
          event.id,
          loggedInUserId);

      final foundTask =
          fetchedTasksList.firstWhere((task) => task.id == event.id);

      foundTask.status = 'completed';
      // print(loggedInUserName);
      add(TaskInitialEvent(userId: prefs.getInt('userId') ?? 0));
    } catch (error) {
      print('this is your error 111 $error');
    }
  }

  FutureOr<void> addTaskButtonClickedEvent(
      AddTaskButtonClickedEvent event, Emitter<TaskState> emit) async {
    HttpService httpService = HttpService();
    var prefs = await SharedPreferences.getInstance();
    final asigneeId = await functions.fetchUserIdByUsername(event.asignee);
    final assignerId = await functions.fetchUserIdByUsername(event.assigner);
    // var prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> taskData = {
      "assigner_id": assignerId,
      "asignee_id": asigneeId,
      "task_description": event.description,
      "task_title": event.title,
      "task_priority": event.priority,
      "task_due_date": functions.convertToIso8601Format(event.dueDate),
    };
    try {
      await httpService.sendAddTaskData(taskData);

      // fetchedTasksList.add(TaskModel(
      //     event.title,
      //     event.description,
      //     event.asignee,
      //     formatDateString(event.dueDate),
      //     event.priority,
      //     event.status,
      //     event.assigner,
      //     addTaskResponse['id_task']));

      add(TaskInitialEvent(userId: prefs.getInt('userId') ?? 0));
    } catch (error) {
      print('error adding task $error');
    }
    emit(TaskLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(TaskLoadingSuccessState(
        tasks: fetchedTasksList, loggedInUserName: loggedInUserName));
  }

  FutureOr<void> taskInitialEvent(
      TaskInitialEvent event, Emitter<TaskState> emit) async {
    HttpService httpService = HttpService();

    var prefs = await SharedPreferences.getInstance();

    try {
      dynamic inProcessTaskData = await httpService.getTaskData(
          prefs.getInt('userId') ?? 0, 'In-Process');
      dynamic completedTaskData = await httpService.getTaskData(
          prefs.getInt('userId') ?? 0, 'Complete');
      List fetchedTasks = [];
      fetchedTasks.addAll(inProcessTaskData['tasks']);
      fetchedTasks.addAll(completedTaskData['tasks']);

      DateTime currentDate = DateTime.now();
      // print(currentDate.year);

      List overdueTasks = fetchedTasks
          .where((task) =>
              DateTime.parse(task['o_task_due_date']).isBefore(currentDate))
          .toList();
      for (int i = 0; i < overdueTasks.length; i++) {
        overdueTasks[i]['task_status'] = 'overdue';
      }

      // print('------------------------------------------------');
      // print(overdueTasks);

      fetchedTasksList = fetchedTasks
          .map<TaskModel>((task) => TaskModel(
              task?['task_title'] ?? '',
              task?['task_description'] ?? '',
              task?['task_assign_to'] ?? '',
              task?['task_due_date'] ?? '',
              task?['task_priority'] ?? '',
              transformStatus(task?['task_status']) ?? '',
              task?['task_assign_by'] ?? '',
              task?['id_task'] ?? ''))
          .toList();

      emit(TaskLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(TaskLoadingSuccessState(
          tasks: fetchedTasksList, loggedInUserName: loggedInUserName));
    } catch (error) {
      print('your error is $error');
    }
  }

  FutureOr<void> dispatchUserDataEvent(
      DispatchUserDataEvent event, Emitter<TaskState> emit) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', int.parse(event.userId));
    loggedInUserId = event.userId;
    HttpService httpService = HttpService();

    dynamic usernameList = await httpService.getUserData();

    loggedInUserName = usernameList['appUserList']
        .firstWhere((user) => user['user_id'] == loggedInUserId)['username'];

    prefs.setString('username', loggedInUserName);
  }
}
