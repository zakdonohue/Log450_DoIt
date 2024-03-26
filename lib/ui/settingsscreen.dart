import 'dart:ffi';

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
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
                child: Center(
              child: Column(children: [
                Text(
                  'Settings page',
                  style: theme.textTheme.titleLarge,
                ),
                const Row(children: [Text("Profile Prive"), CustomSwitch()]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.black),
                ),
                const Row(children: [Text("Theme Fonce"), CustomSwitch()]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.black),
                ),
                const Row(
                    children: [Text("Rappel automatique"), CustomSwitch()]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.black),
                ),
                const Row(
                    children: [Text("Tutoriel personalise"), CustomSwitch()]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.black),
                ),
              ]),
            ))));
  }
}

final createMaterialColor = CreateMaterialColor();
