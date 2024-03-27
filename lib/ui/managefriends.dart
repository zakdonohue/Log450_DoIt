import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/searchBar.dart';
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
        body: const Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(children: [
            CustomSearchBar(),
            // SizedBox.expand(child: Column(children: []))
          ]),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
