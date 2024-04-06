import 'package:flutter/material.dart';
import 'package:log450_doit/homescreen.dart';
import 'package:log450_doit/ui/createtaskscreen.dart';
import 'package:log450_doit/ui/loaderscreen.dart';
import 'package:log450_doit/ui/managefriends.dart';
import 'package:log450_doit/ui/settingsscreen.dart';
import 'package:log450_doit/ui/posttaskscreen.dart';
import 'package:log450_doit/ui/profilescreen.dart';
import 'package:log450_doit/ui/createaccountscreen.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/loginscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  _MainApp createState() => _MainApp();

  static _MainApp of(BuildContext context) =>
      context.findAncestorStateOfType<_MainApp>()!;
}

class _MainApp extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
        CoreApp.routeName: (context) => const CoreAppNavigation(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        CreateTaskScreen.routeName: (context) => const CreateTaskScreen(),
        PostTaskScreen.routeName: (context) => const PostTaskScreen(),
        ManageFriendsScreen.routeName: (context) => const ManageFriendsScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        LoaderScreen.routeName: (context) => const LoaderScreen(),
        HomeScreen.routeName: (context) => const HomeScreen()
      },
      title: "Do It",
      home: const LoginScreen(),
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
