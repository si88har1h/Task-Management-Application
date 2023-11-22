import 'package:sss/application/widgets/app_exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {required this.taskBloc, required this.navigationFunction, super.key});

  final void Function() navigationFunction;
  final taskBloc;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HttpService httpService = HttpService();
  final List<String> categories = ['pending', 'overdue', 'completed'];
  final List<String> selectedCategories = ['pending'];
  Color filterColor = Colors.grey;
  String searchText = '';
  List filteredTasks = [];
  int userId = 0;

  @override
  void initState() {
    // filteredTasks = tasks;
    widget.taskBloc.add(TaskInitialEvent(userId: userId));
    super.initState();
  }

  void loadUserId() async {
    var prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt('userId') ?? 0;
  }

  List filterTasks(
      List tasks, List<String> selectedCategories, String searchText) {
    // Filter based on selected categories
    List filteredByCategories = tasks
        .where((task) => selectedCategories.contains(task.status))
        .toList();

    // Filter based on search text
    if (searchText.isNotEmpty) {
      searchText = searchText.toLowerCase();
      filteredByCategories = filteredByCategories
          .where((task) =>
              task.title.toLowerCase().contains(searchText) ||
              task.asignee.toLowerCase().contains(searchText))
          .toList();
    }

    return filteredByCategories;
  }

  void updateFilteredTasks(String text) {
    setState(() {
      searchText = text;
      filteredTasks = filterTasks(tasks, selectedCategories, searchText);
    });
    // print(searchText);
  }

  void setFilterColor() {
    setState(() {
      filterColor = AppConstants.primaryColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: widget.taskBloc,
      listenWhen: (previous, current) {
        return current is TaskActionState;
      },
      buildWhen: (previous, current) {
        return current is! TaskActionState;
      },
      listener: (context, state) {},
      builder: (context, state) {
        dynamic renderedList = const SizedBox();
        dynamic userInfoWidget = UserInfo(
          navigationFunction: widget.navigationFunction,
          username: 'user',
        );

        if (state.runtimeType == TaskLoadingState) {
          renderedList = const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppConstants.primaryColor)));
        }
        if (state.runtimeType == TaskLoadingSuccessState) {
          // I ALTERED THE INPUT FOR TASKLIST FROM filteredTasks.toList() to successState.tasks
          final successState = state as TaskLoadingSuccessState;
          renderedList = TaskList(
              taskBloc: widget.taskBloc,
              filteredTasks: filterTasks(
                  successState.tasks, selectedCategories, searchText));

          userInfoWidget = UserInfo(
              navigationFunction: widget.navigationFunction,
              username: successState.loggedInUserName);
        }
        if (state.runtimeType == TaskErrorState) {
          renderedList = const Center(
              child: Text(
            'Error loading Tasks  :(',
            style: TextStyle(fontSize: 20, color: AppConstants.primaryColor),
          ));
        }

        return SizedBox(
          width: double.infinity,
          child: Container(
              color: AppConstants.backgroundColor,
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  userInfoWidget,
                  const SizedBox(height: 20),
                  SearchTask(onSearchTextChanged: updateFilteredTasks),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: categories
                          .map((category) => FilterChip(
                              label: Text(category),
                              backgroundColor: Colors.grey,
                              selectedColor: AppConstants.primaryColor,
                              selected: selectedCategories.contains(category),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedCategories.add(category);
                                  } else {
                                    selectedCategories.remove(category);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  renderedList,
                  const SizedBox(height: 40),
                ],
              )),
        );
      },
    );
  }
}
