import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ManageFriendsScreen extends StatelessWidget {
  const ManageFriendsScreen({super.key});

  static const routeName = '/managefriends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        body: const Text("Manage Friends Screen"));
  }
}

final createMaterialColor = CreateMaterialColor();
