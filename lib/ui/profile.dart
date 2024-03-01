import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Profile Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
