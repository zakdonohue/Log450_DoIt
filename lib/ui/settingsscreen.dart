import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/customswitch.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/parameters';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(198, 78, 97, 161)),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(children: [
            Text('Settings page', style: theme.textTheme.titleLarge),
            const Card(
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
                          CustomSwitch()
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          Text("Theme Fonce"),
                          Spacer(),
                          CustomSwitch()
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          Text("Rappel automatique"),
                          Spacer(),
                          CustomSwitch()
                        ]),
                        Divider(color: Colors.black),
                        Row(children: [
                          Text("Tutoriel personalise"),
                          Spacer(),
                          CustomSwitch()
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

final createMaterialColor = CreateMaterialColor();

//TODO implement dark theme
    // final ThemeData themeData = ThemeData(
    //     useMaterial3: true,
    //     brightness: isDark ? Brightness.dark : Brightness.light);
    //  Tooltip(
    //         message: 'Change brightness mode',
    //         child: IconButton(
    //           isSelected: isDark,
    //           onPressed: () {
    //             setState(() {
    //               isDark = !isDark;
    //             });
    //           },
    //           icon: const Icon(Icons.wb_sunny_outlined),
    //           selectedIcon: const Icon(Icons.brightness_2_outlined),
    //         ),
    //       )