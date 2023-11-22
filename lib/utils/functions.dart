import 'package:flutter/material.dart';
import 'package:sss/utils/styles.dart' as icon_styles;
import 'package:sss/utils/http_service.dart';
// import 'package:intl/intl.dart';

String limitStringLength(String string) {
  String rand = '...';
  if (string.length > 40) {
    return string.substring(0, 39) + rand;
  }

  return string;
}

transformStatus(String currentStatus) {
  if (currentStatus == 'In-Process') {
    return 'pending';
  } else if (currentStatus == 'Complete') {
    return 'completed';
  } else if (currentStatus == 'overdue') {
    return 'overdue';
  }
}

renderButton(String status) {
  if (status == 'completed') {
    return const SizedBox(
      width: 0,
    );
  } else {
    return TextButton(
      style: ButtonStyle(
          iconColor:
              MaterialStateProperty.all(icon_styles.scheduleIndicator(status))),
      onPressed: null,
      child: const Icon(Icons.watch_later_outlined),
    );
  }
}

Future<String> fetchUserIdByUsername(String username) async {
  // print(username);
  HttpService httpService = HttpService();

  dynamic usernameList = await httpService.getUserData();

  String loggedInUserId = usernameList['appUserList']
      .firstWhere((user) => user['username'] == username)['user_id'];
  return loggedInUserId;
}

String convertToIso8601Format(String inputDate) {
  // Split the input date into month and day
  List<String> dateParts = inputDate.split(' ');

  // Get year, month, and day
  String year = DateTime.now().year.toString();
  String month = dateParts[0];
  String day = dateParts[1];

  // Map month names to their numerical representation
  Map<String, String> monthMap = {
    'January': '01',
    'February': '02',
    'March': '03',
    'April': '04',
    'May': '05',
    'June': '06',
    'July': '07',
    'August': '08',
    'September': '09',
    'October': '10',
    'November': '11',
    'December': '12',
  };

  // Format the day to have leading zero if needed
  day = day.padLeft(2, '0');

  // Get the numerical representation of the month
  String? monthNumber = monthMap[month];

  // Create the formatted date in "YYYY-MM-DD" format
  String formattedDate = '$year-$monthNumber-$day';

  return formattedDate;
}

Map<String, int?> parseDueDate(String dueDate) {
  try {
    RegExpMatch? match =
        RegExp(r'(\d+)(?:st|nd|rd|th) (\w+)').firstMatch(dueDate);

    // Extract day and month from the matched groups
    if (match != null) {
      // Extract day and month from the matched groups
      int day = int.tryParse(match.group(1) ?? '') ?? 0;
      int month = parseMonth(match.group(2) ?? '');
      return {'day': day, 'month': month};
    }
  } catch (e) {
    // Handle parsing errors
  }

  return {'day': null, 'month': null};
}

int parseMonth(String monthString) {
  switch (monthString.toLowerCase()) {
    case 'jan':
      return 1;
    case 'feb':
      return 2;
    case 'mar':
      return 3;
    case 'apr':
      return 4;
    case 'may':
      return 5;
    case 'june':
      return 6;
    case 'july':
      return 7;
    case 'aug':
      return 8;
    case 'sep':
      return 9;
    case 'oct':
      return 10;
    case 'nov':
      return 11;
    case 'dec':
      return 12;
    default:
      return 0;
  }
}

String formatDateString(String inputDate) {
  try {
    RegExpMatch? match =
        RegExp(r'(\d+)(?:st|nd|rd|th) (\w+)').firstMatch(inputDate);

    if (match != null) {
      int day = int.tryParse(match.group(1) ?? '') ?? 0;
      String monthAbbreviation = match.group(2) ?? '';

      if (day >= 1 && day <= 31) {
        // Use ordinal suffix for the day
        String dayWithSuffix = '$day' + _getOrdinalSuffix(day);

        return '$dayWithSuffix $monthAbbreviation';
      }
    }
  } catch (e) {
    // Handle parsing errors
  }

  return inputDate; // Return the original date if the format is not matched
}

String _getOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }

  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
