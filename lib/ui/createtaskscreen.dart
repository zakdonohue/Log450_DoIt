import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  static const routeName = '/createtask';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Create Task Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
