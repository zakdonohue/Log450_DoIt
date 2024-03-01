import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  static const routeName = '/loader';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Loader Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
