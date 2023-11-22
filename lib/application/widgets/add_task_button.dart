import 'package:flutter/material.dart';
import 'package:sss/application/widgets/add_task_form.dart';
import 'package:sss/utils/app_constants.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton(this.buttonText, {required this.taskBloc, super.key});

  final String buttonText;
  final taskBloc;

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 4.0,
      backgroundColor: AppConstants.primaryColor,
      icon: const Icon(Icons.add),
      label: Text(widget.buttonText),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddTaskForm(taskBloc: widget.taskBloc)));
      },
    );
  }
}
