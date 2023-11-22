import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sss/application/widgets/task_details.dart';
import 'package:sss/utils/styles.dart' as icon_styles;
import 'package:sss/utils/functions.dart' as functions;

class TaskList extends StatefulWidget {
  const TaskList(
      {required this.taskBloc, required this.filteredTasks, super.key});
  final List filteredTasks;
  final taskBloc;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple,
              Colors.transparent,
              Colors.transparent,
              Colors.purple
            ],
            stops: [
              0.0,
              0.1,
              0.9,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: ListView.builder(
            itemCount: widget.filteredTasks.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print(widget.filteredTasks);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => TaskDetails(
                          taskBloc: widget.taskBloc,
                          title: widget.filteredTasks[index].title,
                          description: widget.filteredTasks[index].description,
                          asignee: widget.filteredTasks[index].asignee,
                          dueDate: widget.filteredTasks[index].dueDate,
                          priority: widget.filteredTasks[index].priority,
                          assigner: widget.filteredTasks[index].assigner,
                          status: widget.filteredTasks[index].status,
                          id: widget.filteredTasks[index].id)));
                },
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(widget.filteredTasks[index].title,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700)),
                        ),
                        subtitle: Text(
                          widget.filteredTasks[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/avatar.jpg",
                                      ),
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(widget.filteredTasks[index].asignee,
                                  overflow: TextOverflow.fade),
                            ),
                            const SizedBox(width: 30),
                            CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/admin.png",
                                      ),
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                widget.filteredTasks[index].assigner,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          functions
                              .renderButton(widget.filteredTasks[index].status),
                          const SizedBox(width: 8),
                          TextButton(
                            style: ButtonStyle(
                                iconColor: MaterialStateProperty.all(
                                    icon_styles.priorityIndicator(
                                        widget.filteredTasks[index].priority))),
                            onPressed: null,
                            child: const Icon(Icons.circle),
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
