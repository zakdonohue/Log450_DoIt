import 'package:flutter/material.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/main.dart';
import 'package:log450_doit/ui/reusableWidgets/customswitchnotif.dart';
import 'package:log450_doit/ui/reusableWidgets/customswitchprivacy.dart';
import 'package:log450_doit/ui/reusableWidgets/customswitchtheme.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/parameters';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Future<void> _logout(BuildContext context) async {
      // Clear SharedPreferences
      SharedPreferences.shared.userId = "";

      // Navigate to Login Screen
      Navigator.of(context).pushNamed('/login');
    }

    bool isDarkMode = false;

    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(255, 65, 180, 238)),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(children: [
            const Text(
              'Réglages', 
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40.0,
                )),
            Card(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.all(8.0),
                child: Wrap(children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Row(children: [
                          const Text("Profil Privé",
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                          )),
                          Spacer(),
                          CustomSwitchPrivacy(callbackON: () {
                            _EditSettings(
                                true,
                                SharedPreferences.shared.isNotificationEnabled,
                                SharedPreferences.shared.userId);
                          }, callbackOFF: () {
                            _EditSettings(
                                false,
                                SharedPreferences.shared.isNotificationEnabled,
                                SharedPreferences.shared.userId);
                          })
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          const Text("Thème Foncé",
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                          )),
                          Spacer(),
                          CustomSwitchTheme(callbackON: () {
                            MainApp.of(context).changeTheme(ThemeMode.dark);
                          }, callbackOFF: () {
                            MainApp.of(context).changeTheme(ThemeMode.light);
                          })
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          const Text("Rappel automatique",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                          )),
                          Spacer(),
                          CustomSwitchNotification(callbackON: () {
                            _EditSettings(
                                SharedPreferences.shared.isAccountPrivate,
                                true,
                                SharedPreferences.shared.userId);
                            CoreAppNavigation.of(context)
                                .GetUserTasksNotCompleted(
                                    SharedPreferences.shared.userId);
                          }, callbackOFF: () {
                            _EditSettings(
                                SharedPreferences.shared.isAccountPrivate,
                                false,
                                SharedPreferences.shared.userId);
                          })
                        ]),
                        Divider(color: Colors.black),
                        TextButton.icon(
                          onPressed: () => _logout(context),
                          icon: Icon(Icons.logout, color: Colors.black),
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ]),
                    ),
                  )
                ]))
          ]),
        )));
  }
}

Future<void> _EditSettings(
    bool? isAccountPrivate, bool? isNotifEnabled, String userId) async {
  String apiUrl = "http://10.0.2.2:3000/users/$userId/settings";

  try {
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "is_account_private": isAccountPrivate,
        "notifications_enabled": isNotifEnabled
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("Settings updated successfully");
    } else {
      print("Failed to update settings: ${response.body}");
    }
  } catch (e) {
    print("Error update settings: $e");
  }
}

final createMaterialColor = CreateMaterialColor();
