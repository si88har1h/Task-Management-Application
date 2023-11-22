import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sss/application/blocs/bloc/task_bloc.dart';
import 'package:sss/utils/styles.dart' as icon_styles;

class TaskDetails extends StatelessWidget {
  const TaskDetails(
      {required this.taskBloc,
      required this.title,
      required this.description,
      required this.asignee,
      required this.dueDate,
      required this.priority,
      required this.assigner,
      required this.status,
      required this.id,
      super.key});

  final String title;
  final String description;
  final String asignee;
  final String dueDate;
  final String priority;
  final String assigner;
  final String status;
  final String id;
  final taskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: taskBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      icon_styles.completedButtonColor(status))),
              onPressed: status == 'completed'
                  ? null
                  : () {
                      taskBloc.add(CompletedButtonClickedEvent(
                          title: title,
                          description: description,
                          asignee: asignee,
                          dueDate: dueDate,
                          priority: priority,
                          assigner: assigner,
                          status: status,
                          id: id));
                      Navigator.of(context).pop();
                    },
              child: Center(
                child: Text(
                  icon_styles.completedButtonText(status),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 33, 40, 50),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 33, 40, 50),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Task Details',
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.w400),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.saira(fontSize: 35, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        icon_styles.utilityIcons(Icons.calendar_month_outlined),
                        icon_styles.utilityData('Due Date', dueDate)
                      ],
                    ),
                    Row(children: [
                      icon_styles.utilityIcons(Icons.crisis_alert),
                      icon_styles.utilityData('Priority', priority)
                    ])
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Description',
                      style: icon_styles.subheadingStyles(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      description,
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 188, 207, 216)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assigned To: ',
                      style: icon_styles.subheadingStyles(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/avatar.jpg",
                                  ),
                                ))),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(asignee,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 188, 207, 216)))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assigned By: ',
                      style: icon_styles.subheadingStyles(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/admin.png",
                                  ),
                                ))),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(assigner,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 188, 207, 216)))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
