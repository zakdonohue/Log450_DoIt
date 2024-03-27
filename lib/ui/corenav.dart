import 'package:flutter/material.dart';
import 'package:log450_doit/homescreen.dart';
import 'package:log450_doit/ui/createtaskscreen.dart';
import 'package:log450_doit/ui/managefriends.dart';
import 'package:log450_doit/ui/profilescreen.dart';
import 'package:log450_doit/ui/settingsscreen.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class CoreApp extends State<CoreAppNavigation> {
  static const routeName = '/corenav';
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(200, 97, 115, 160)),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Profil',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.task),
            icon: Icon(Icons.task_outlined),
            label: 'Taches',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people_alt),
            icon: Icon(Icons.people_alt_outlined),
            label: 'Amis',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Parametres',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const HomeScreen(),
        const ProfileScreen(),
        const CreateTaskScreen(),
        const ManageFriendsScreen(),
        const SettingsScreen(),
      ][currentPageIndex],
    );
  }
}

//}

final createMaterialColor = CreateMaterialColor();

class CoreAppNavigation extends StatefulWidget {
  const CoreAppNavigation({super.key});

  @override
  State<CoreAppNavigation> createState() => CoreApp();
}

// class _NavigationExampleState extends State<NavigationExample> {
  