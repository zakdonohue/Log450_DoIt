import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  static const routeName = '/createtask';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(198, 167, 107, 17)),
        body: Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Task page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
