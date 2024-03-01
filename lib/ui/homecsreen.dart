import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(Color.fromARGB(198, 147, 97, 160)),
        body: const Text("Home Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
