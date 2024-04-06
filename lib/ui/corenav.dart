import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/homescreen.dart';
import 'package:log450_doit/ui/createtaskscreen.dart';
import 'package:log450_doit/ui/managefriends.dart';
import 'package:log450_doit/ui/profilescreen.dart';
import 'package:log450_doit/ui/settingsscreen.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class CoreApp extends State<CoreAppNavigation> {
  static const routeName = '/corenav';
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _GetSettings("6610b7fb661864dc02c472e7");
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
            _buildNavItem(Icons.people_alt_outlined, "Amis", 2),
            _buildNavItem(Icons.settings_outlined, "Réglages", 3),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF0AAAF8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          HomeScreen(),
          ProfileScreen(),
          ManageFriendsScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    Color iconColor = currentPageIndex == index
        ? Colors.blue
        : Colors.grey; // Adjust colors as needed
    return InkWell(
      onTap: () {
        setState(() {
          currentPageIndex = index;
        });
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

class CoreAppNavigation extends StatefulWidget {
  const CoreAppNavigation({super.key});

  @override
  State<CoreAppNavigation> createState() => CoreApp();
}

Future<void> _GetSettings(String userId) async {
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
