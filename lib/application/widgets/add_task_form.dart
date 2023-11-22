import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss/application/blocs/bloc/task_bloc.dart';
import 'package:sss/application/widgets/reusables/app_text_form_field.dart';
import 'package:sss/application/widgets/reusables/elevated_button.dart';
import 'package:sss/utils/app_constants.dart';
import 'package:sss/utils/styles.dart' as styles;

import 'package:sss/data/asignees.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({required this.taskBloc, super.key});

  final taskBloc;

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text('Add Task Form'),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm(taskBloc: widget.taskBloc)),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({required this.taskBloc, super.key});
  final taskBloc;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String taskTitle = '';
  String taskDescription = '';
  int _selectedPriority = 0;
  int _selectedAsignee = 0;

  int get selectedPriority => _selectedPriority;
  int get selectedAsignee => _selectedAsignee;

  List<DropdownMenuItem<int>> priorityList = [];
  List<DropdownMenuItem<int>> asigneeList = [];
  List<String> asignees = [];

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    asignees = [];
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await Asignees.fetchAsignees();
    setState(() {
      asignees = Asignees.asignees;
    });
  }

  void loadPriorityList() {
    priorityList = [];
    for (int i = 0; i < priorities.length; i++) {
      priorityList.add(DropdownMenuItem(
        value: i,
        child: Text(priorities[i]),
      ));
    }
  }

  void loadAsigneeList() {
    asigneeList = [];
    for (int i = 0; i < asignees.length; i++) {
      asigneeList.add(DropdownMenuItem(
        value: i,
        child: Text(asignees[i]),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadPriorityList();
    loadAsigneeList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Task Title',
        hintText: '',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a task title';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        setState(() {
          taskTitle = value;
        });
      },
    ));

    validateDescription(String? value) {
      if (value!.isEmpty) {
        return 'Please enter a description';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Task Description', hintText: 'Description'),
      keyboardType: TextInputType.emailAddress,
      validator: validateDescription,
      onChanged: (value) {
        setState(() {
          taskDescription = value;
        });
      },
    ));

    formWidget.add(const SizedBox(height: 20));
    formWidget.add(const Text('Select Priority'));

    formWidget.add(AppDropdownButton(
        text: 'Select Priority',
        onChange: (value) {
          setState(() {
            _selectedPriority = int.parse(value.toString());
          });
        },
        itemsList: priorityList,
        itemSelected: _selectedPriority));

    formWidget.add(const SizedBox(height: 20));
    formWidget.add(const Text('Select Asignee'));

    formWidget.add(AppDropdownButton(
        text: 'Select Asignee',
        onChange: (value) {
          setState(() {
            _selectedAsignee = int.parse(value.toString());
          });
        },
        itemsList: asigneeList,
        itemSelected: _selectedAsignee));

    formWidget.add(const SizedBox(height: 20));

    formWidget.add(TextField(
      controller: dateInput,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month,
                DateTime.now().day));

        if (pickedDate != null) {
          String formattedDate =
              '${DateFormat.MMMM().format(pickedDate)} ${DateFormat.d().format(pickedDate)}';

          // print(formattedDate);

          setState(() {
            dateInput.text = formattedDate;
          });
        }
      },
    ));

    formWidget.add(const SizedBox(height: 20));

    void onPressedSubmit() async {
      // final TaskBloc taskBloc = TaskBloc();
      try {
        var prefs = await SharedPreferences.getInstance();
        String username = prefs.getString('username').toString();
        var uuid = const Uuid();

        if (_formKey.currentState!.validate()) {
          // DEFINING THE EVENT FOR CLICKING THE ADD TASK BUTTON
          widget.taskBloc.add(AddTaskButtonClickedEvent(
              title: taskTitle,
              description: taskDescription,
              dueDate: dateInput.text,
              asignee: asignees[selectedAsignee],
              priority: priorities[selectedPriority],
              assigner: username,
              status: 'pending',
              id: uuid.v1()));
          _formKey.currentState?.save();

          styles.customSnackBar(
              _formKey.currentContext, 'Task added Successfully');

          print('Task added');
          Navigator.of(_formKey.currentContext ?? context).pop();
        }
      } catch (error) {
        print('hardcoded error $error');
      }
    }

    formWidget.add(CustomElevatedButton(
        buttonText: 'Add Task', onClicked: onPressedSubmit));

    return formWidget;
  }
}
