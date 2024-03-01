import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/createaccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Create Acount Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
