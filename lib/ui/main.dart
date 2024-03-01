import 'package:flutter/material.dart';
import 'package:log450_doit/ui/createtaskscreen.dart';
import 'package:log450_doit/ui/loaderscreen.dart';
import 'package:log450_doit/ui/managefriends.dart';
import 'package:log450_doit/ui/parametersscreen.dart';
import 'package:log450_doit/ui/posttaskscreen.dart';
import 'package:log450_doit/ui/profile.dart';
import 'package:log450_doit/ui/createaccountscreen.dart';
import 'package:log450_doit/ui/homecsreen.dart';
import 'package:log450_doit/ui/loginscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      ProfileScreen.routeName: (context) => const ProfileScreen(),
      CreateTaskScreen.routeName: (context) => const CreateTaskScreen(),
      PostTaskScreen.routeName: (context) => const PostTaskScreen(),
      ManageFriendsScreen.routeName: (context) => const ManageFriendsScreen(),
      ParametersScreen.routeName: (context) => const ParametersScreen(),
      LoaderScreen.routeName: (context) => const LoaderScreen()
    }, title: "Do It", home: const LoginScreen());
  }
}
