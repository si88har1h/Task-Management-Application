import 'dart:convert';
import 'package:http/http.dart';
import 'package:sss/utils/functions.dart' as functions;

class HttpService {
  Future getUserLoginData(
      String username, String password, String usage) async {
    String postsURL =
        "https://gateway.streetstylestore.com/admin2014/custom-api/$usage.php";

    Map<String, String> credentials = {
      'username': username,
      'password': password,
    };

    String requestBody = jsonEncode(credentials);

    Response res = await post(
      Uri.parse(postsURL),
      headers: {
        'Content-Type': 'application/json',
        'Referer': 'https://streetstylestore.com'
      },
      body: requestBody,
    );

    if (res.statusCode == 200) {
      dynamic responseData = jsonDecode(res.body);
      return responseData;
    } else {
      throw "Unable to retrieve data. Status code: ${res.statusCode}";
    }
  }

  // Future getTaskData(
  //   int userId,
  //   String status,
  // ) async {
  //   String postsURL =
  //       "https://webhook.site/1bbd9a91-26ff-4189-8902-03388411f705";

  //   Map<String, dynamic> payload = {
  //     "type": "getTaskList",
  //     "id_task": "0",
  //     "user_id": "$userId",
  //     "task_status": {"id": status, "text": status}
  //   };

  //   String requestBody = jsonEncode(payload);

  //   Response res = await post(
  //     Uri.parse(postsURL),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: requestBody,
  //   );

  //   if (res.statusCode == 200) {
  //     dynamic responseData = jsonDecode(res.body);
  //     return responseData;
  //   } else {
  //     throw "Unable to retrieve data. Status code: ${res.statusCode}";
  //   }
  // }

  Future getTaskData(
    int userId,
    String status,
  ) async {
    String postsURL =
        "https://gateway.streetstylestore.com/admin2014/custom-api/common/taskRequest.php";

    Map<String, dynamic> payload = {
      "type": "getTaskList",
      "id_task": "0",
      "user_id": "$userId",
      "task_status": {"id": status, "text": status}
    };

    String requestBody = jsonEncode(payload);

    Response res = await post(
      Uri.parse(postsURL),
      headers: {
        'Content-Type': 'application/json',
        'Referer': 'https://streetstylestore.com'
      },
      body: requestBody,
    );

    if (res.statusCode == 200) {
      dynamic responseData = jsonDecode(res.body);
      return responseData;
    } else {
      throw "Unable to retrieve data. Status code: ${res.statusCode}";
    }
  }

  Future sendAddTaskData(
    taskData,
  ) async {
    String postsURL =
        "https://gateway.streetstylestore.com/admin2014/custom-api/common/taskRequest.php";

    Map<String, dynamic> payload = {
      "type": "saveTask",
      "task": {
        "task_assign_by": {"id": taskData['assigner_id'], "text": ""},
        "task_assign_to": {"id": taskData['asignee_id'], "text": ""},
        "task_description": "${taskData['task_description']}",
        "task_title": "${taskData['task_title']}",
        "task_priority": {
          "id": "${taskData['task_priority']}",
          "text": "${taskData['task_priority']}"
        },
        "task_due_date": "${taskData['task_due_date']}",
        "task_status": {"id": "In-Process", "text": "In-Process"},
        "task_created_by": "${taskData['assigner_id']}"
      },
      "id_task": 0
    };

    String requestBody = jsonEncode(payload);

    Response res = await post(
      Uri.parse(postsURL),
      headers: {
        'Content-Type': 'application/json',
        'Referer': 'https://streetstylestore.com'
      },
      body: requestBody,
    );

    if (res.statusCode == 200) {
      dynamic responseData = jsonDecode(res.body);
      return responseData;
    } else {
      throw "Unable to retrieve data. Status code: ${res.statusCode}";
    }
  }

  Future sendCompletedTaskData(title, description, asignee, dueDate, priority,
      assigner, status, id, loggedInUserId) async {
    String postsURL =
        "https://gateway.streetstylestore.com/admin2014/custom-api/common/taskRequest.php";

    Map<String, dynamic> payload = {
      "type": "saveTask",
      "task": {
        "task_assign_by": {"id": loggedInUserId, "text": assigner},
        "task_assign_to": {
          "id": await functions.fetchUserIdByUsername(asignee),
          "text": asignee
        },
        "task_description": description,
        "task_title": title,
        "task_priority": {"id": priority, "text": priority},
        "task_due_date": dueDate,
        "task_status": {"id": status, "text": status},
        "task_created_by": loggedInUserId
      },
      "id_task": id
    };

    String requestBody = jsonEncode(payload);

    Response res = await post(
      Uri.parse(postsURL),
      headers: {
        'Content-Type': 'application/json',
        'Referer': 'https://streetstylestore.com'
      },
      body: requestBody,
    );

    if (res.statusCode == 200) {
      dynamic responseData = jsonDecode(res.body);
      return responseData;
    } else {
      throw "Unable to retrieve data. Status code: ${res.statusCode}";
    }
  }

  Future getUserData() async {
    String postsURL =
        "https://gateway.streetstylestore.com/admin2014/custom-api/getUser.php";

    // Map<String, dynamic> payload = {
    //   "type": "getTaskList",
    //   "id_task": "0",
    //   "user_id": "$userId",
    //   "task_status": {"id": "In-Process", "text": "In-Process"}
    // };

    // String requestBody = jsonEncode(payload);

    Response res = await post(
      Uri.parse(postsURL),
      headers: {
        'Content-Type': 'application/json',
        'Referer': 'https://streetstylestore.com'
      },
      // body: requestBody,
    );

    if (res.statusCode == 200) {
      dynamic responseData = jsonDecode(res.body);
      return responseData;
    } else {
      throw "Unable to retrieve data. Status code: ${res.statusCode}";
    }
  }
}
