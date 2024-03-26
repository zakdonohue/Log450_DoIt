import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ManageFriendsScreen extends StatelessWidget {
  const ManageFriendsScreen({super.key});

  static const routeName = '/managefriends';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(198, 163, 33, 104)),
        body: Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Friends page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
