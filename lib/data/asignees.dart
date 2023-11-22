import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss/utils/http_service.dart';

class Asignees {
  static List<String> asignees = [];

  static Future<void> fetchAsignees() async {
    // Add your API fetching logic here
    // For example, using an imaginary API class
    // final List<String> fetchedData = await ApiClass.fetchAsigneesFromApi();
    HttpService httpService = HttpService();

    dynamic usernameList = await httpService.getUserData();

    final List<String> fetchedData =
        (usernameList['appUserList'] as List<dynamic>)
            .map<String>(
                (user) => (user as Map<String, dynamic>)['username'] as String)
            .toList();

    asignees = fetchedData;
  }
}

const priorities = ['Low', 'Medium', 'High'];

class User {
  static String user = '';

  static Future<String> fetchUser() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.getInt('userId');

    HttpService httpService = HttpService();

    dynamic usernameList = await httpService.getUserData();

    user = usernameList['appUserList'].firstWhere(
        (user) => user['user_id'] == prefs.getInt('userId'))['username'];

    return user;
  }
}
