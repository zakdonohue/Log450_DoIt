import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(Color.fromARGB(197, 17, 167, 122)),
        body: Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Profile page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
