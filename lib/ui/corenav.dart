import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/homescreen.dart';
import 'package:log450_doit/ui/createtaskscreen.dart';
import 'package:log450_doit/ui/managefriends.dart';
import 'package:log450_doit/ui/profilescreen.dart';
import 'package:log450_doit/ui/settingsscreen.dart';
import 'package:log450_doit/ui/utils/localnotifservice.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

GlobalKey<ProfileScreenState> profileScreenKey = GlobalKey<ProfileScreenState>();

class CoreAppNavigation extends StatefulWidget {
  const CoreAppNavigation({super.key});

  @override
  State<CoreAppNavigation> createState() => CoreApp();
  static CoreApp of(BuildContext context) =>
      context.findAncestorStateOfType<CoreApp>()!;
}

class CoreApp extends State<CoreAppNavigation> {
  static const routeName = '/corenav';
  int currentPageIndex = 0;

  Future<void> GetUserTasksNotCompleted(String userId) async {
    String apiUrl = "http://10.0.2.2:3000/users/$userId";
    int numberofTaskNotCompleted = 0;
    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("get user successfully");
        final parsedJson = jsonDecode(response.body);
        List<dynamic> listTask = parsedJson["tasks"];

        for (var i = 0; i < listTask.length; i++) {
          print(listTask[i]["isDone"]);
          if (!listTask[i]["isDone"]) {
            numberofTaskNotCompleted += 1;
          }
        }

        if (numberofTaskNotCompleted > 0) {
          LocalNotificationService.showNotificationAndroid(
              numberofTaskNotCompleted);
        }
        numberofTaskNotCompleted = 0;
      } else {
        print("Failed to get user: ${response.body}");
      }
    } catch (e) {
      print("Error get user: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    LocalNotificationService().init();
  }

  @override
  Widget build(BuildContext context) {
    GetSettings(SharedPreferences.shared.userId);
    if (SharedPreferences.shared.isNotificationEnabled) {
      GetUserTasksNotCompleted(SharedPreferences.shared.userId);
    }
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home_outlined, "Actualité", 0),
            _buildNavItem(Icons.task_outlined, "Taches", 1),
            SizedBox(width: 48),
            _buildNavItem(Icons.people_alt_outlined, "Amis", 3),
            _buildNavItem(Icons.settings_outlined, "Réglages", 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentPageIndex = 2;
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF0AAAF8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          const HomeScreen(),
          ProfileScreen(key: profileScreenKey),
          const CreateTaskScreen(),
          const ManageFriendsScreen(),
          const SettingsScreen(),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    Color iconColor = currentPageIndex == index ? Colors.blue : Colors.grey;
    return InkWell(
      onTap: () {
        setState(() {
          currentPageIndex = index;
        });
        print(index);
        if (index == 1) {
          profileScreenKey.currentState?.fetchUserTasks();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: iconColor),
          Text(label, style: TextStyle(color: iconColor))
        ],
      ),
    );
  }
}

final createMaterialColor = CreateMaterialColor();

Future<void> GetSettings(String userId) async {
  String apiUrl = "http://10.0.2.2:3000/users/$userId/settings";

  try {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {"Content-Type": "application/json"});

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("Settings updated successfully");
      final parsedJson = jsonDecode(response.body);
      print('${parsedJson.runtimeType} : $parsedJson');

      SharedPreferences.shared.isAccountPrivate =
          parsedJson["is_account_private"];
      SharedPreferences.shared.isNotificationEnabled =
          parsedJson["notifications_enabled"];
    } else {
      print("Failed to update settings: ${response.body}");
    }
  } catch (e) {
    print("Error update settings: $e");
  }
}
