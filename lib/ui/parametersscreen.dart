import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ParametersScreen extends StatelessWidget {
  const ParametersScreen({super.key});

  static const routeName = '/parameters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Parameters Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
