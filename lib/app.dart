import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss/application/blocs/bloc/task_bloc.dart';
import 'package:sss/screens/dashboard.dart';
import 'package:sss/application/widgets/add_task_button.dart';
import 'package:sss/screens/login_screen.dart';
import 'package:sss/screens/start_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String screenName = '';
  dynamic fetchedUserId;
  var prefs;
  var boolKey;

  final TaskBloc taskBloc = TaskBloc();

  @override
  void initState() {
    loadPrefs();
    super.initState();
  }

  void loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    boolKey = 'isFirstTime';
    var isFirstTime = prefs.getBool(boolKey) ?? true;
    screenName = isFirstTime ? 'start-screen' : 'LoginPage';
  }

  void navigateToLogin() async {
    setState(() {
      screenName = 'LoginPage';
    });
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(boolKey, false);
  }

  void navigateToDashboard() {
    setState(() {
      screenName = 'dashboard';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderScreen = StartScreen(
      onChange: navigateToLogin,
    );

    if (screenName == 'start-screen') {
      renderScreen = StartScreen(
        onChange: navigateToLogin,
      );
    } else if (screenName == 'dashboard') {
      renderScreen =
          Dashboard(taskBloc: taskBloc, navigationFunction: navigateToLogin);
    } else if (screenName == 'LoginPage') {
      renderScreen = LoginPage(
        taskBloc: taskBloc,
        navigationFunction: navigateToDashboard,
      );
    }

    final AddTaskButton? renderFloatingButton = screenName == 'dashboard'
        ? AddTaskButton('Add Task', taskBloc: taskBloc)
        : null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: renderFloatingButton,
        appBar: null,
        body: renderScreen,
      ),
    );
  }
}
