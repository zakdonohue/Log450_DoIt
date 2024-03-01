import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class PostTaskScreen extends StatelessWidget {
  const PostTaskScreen({super.key});

  static const routeName = '/posttask';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Post Task Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
