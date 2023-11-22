import 'package:sss/models/task_model.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();

DateTime convertStringToDate(String inputDate) {
  DateFormat inputDateFormat = DateFormat('MMMM d');

  DateTime parsedDate = inputDateFormat.parse(inputDate);

  return parsedDate;
}

String checkOverdue(String dueDate) {
  DateTime date = convertStringToDate(dueDate);

  if (now.isAfter(date)) {
    return 'overdue';
  } else if (now.isBefore(date)) {
    return 'pending';
  } else {
    return 'pending';
  }
}

var tasks = [
  TaskModel(
      'Develop task manager',
      'develop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task managerdevelop task manager',
      'Siddharth Mehta',
      'May 17',
      'Low',
      'overdue',
      'Jai',
      '1'),
  TaskModel('Kill all bugs', 'kill all the bugs present out there',
      'Jain Sahab', 'November 23', 'Medium', 'pending', 'Jai', '2'),
  TaskModel('increase sales tinight', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'Medium', 'completed', 'Jai', '3'),
  TaskModel('increase AOV', 'do it fast', 'Siddharth Mehta', 'July 20', 'High',
      'overdue', 'Jai', '4'),
  TaskModel(
      'Complete project',
      'complete the project given to you asap complete the project given to you asapcomplete the project given to you asap',
      'Siddharth Mehta',
      'July 20',
      'High',
      'completed',
      'Jai',
      '5'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'completed', 'Jai', '6'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'pending', 'Jai', '7'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'completed', 'Jai', '8'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'pending', 'Jai', '9'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'overdue', 'Jai', '10'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'overdue', 'Jai', '11'),
  TaskModel('Complete project', 'complete the project given to you asap',
      'Siddharth Mehta', 'July 20', 'High', 'completed', 'Jai', '12'),
];
