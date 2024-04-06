import 'package:flutter/material.dart';
import 'package:log450_doit/ui/main.dart';
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
    bool isDarkMode = false;
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(198, 78, 97, 161)),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(children: [
            Text('Settings page', style: theme.textTheme.titleLarge),
            Card(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.all(8.0),
                child: Wrap(children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Row(children: [
                          Text("Profile Prive"),
                          Spacer(),
                          CustomSwitchPrivacy(callbackON: () {
                            // _EditSettings(
                            //   true,
                            //   false,
                            //   "6610b7fb661864dc02c472e7",
                            // );
                            _GetSettings("6610b7fb661864dc02c472e7");
                          }, callbackOFF: () {
                            _EditSettings(
                              false,
                              false,
                              "6610b7fb661864dc02c472e7",
                            );
                          })
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          Text("Theme Fonce"),
                          Spacer(),
                          CustomSwitchTheme(callbackON: () {
                            MainApp.of(context).changeTheme(ThemeMode.dark);
                          }, callbackOFF: () {
                            MainApp.of(context).changeTheme(ThemeMode.light);
                          })
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          Text("Rappel automatique"),
                          Spacer(),
                          CustomSwitchPrivacy(callbackON: () {
                            _EditSettings(
                                false, true, "6610b7fb661864dc02c472e7");
                          }, callbackOFF: () {
                            _EditSettings(
                              false,
                              false,
                              "6610b7fb661864dc02c472e7",
                            );
                          })
                        ]),
                        Divider(color: Colors.black),
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

Future<void> _GetSettings(String userId) async {
  String apiUrl = "http://10.0.2.2:3000/users/$userId/settings";

  try {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {"Content-Type": "application/json"});

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("Settings updated successfully");
      final parsedJson = jsonDecode(response.body);
      print('${parsedJson.runtimeType} : $parsedJson');
      print(parsedJson["is_account_private"]);
      print(parsedJson["notifications_enabled"]);
    } else {
      print("Failed to update settings: ${response.body}");
    }
  } catch (e) {
    print("Error update settings: $e");
  }
}

final createMaterialColor = CreateMaterialColor();
