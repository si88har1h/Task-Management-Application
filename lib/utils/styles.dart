import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sss/utils/app_constants.dart';

Container utilityIcons(iconName) {
  return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: AppConstants.primaryColor)),
      child: Icon(
        iconName,
        color: AppConstants.primaryColor,
      ));
}

Column utilityData(text, dataValue) {
  Color priorityColor = Colors.white;

  if (dataValue == 'High') {
    priorityColor = Colors.red;
  }
  if (dataValue == 'Medium') {
    priorityColor = Colors.yellow;
  }
  if (dataValue == 'Low') {
    priorityColor = Colors.green;
  }

  return Column(
    children: [
      Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 140, 170, 185)),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        dataValue,
        style: TextStyle(fontWeight: FontWeight.bold, color: priorityColor),
      )
    ],
  );
}

TextStyle subheadingStyles() {
  return GoogleFonts.montserrat(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);
}

Color scheduleIndicator(String status) {
  if (status == 'pending') {
    return Colors.orange;
  } else if (status == 'completed') {
    return Colors.green;
  } else if (status == 'overdue') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

Color priorityIndicator(String priority) {
  if (priority == 'Low') {
    return Colors.green;
  } else if (priority == 'Medium') {
    return Colors.yellow;
  } else if (priority == 'High') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

Color completedButtonColor(String status) {
  if (status == 'completed') {
    return Colors.grey;
  } else {
    return AppConstants.primaryColor;
  }
}

String completedButtonText(String status) {
  if (status == 'completed') {
    return 'Completed';
  } else {
    return 'Mark as Completed';
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    context, text,
    [color = AppConstants.primaryColor]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(text),
    ),
  );
}
